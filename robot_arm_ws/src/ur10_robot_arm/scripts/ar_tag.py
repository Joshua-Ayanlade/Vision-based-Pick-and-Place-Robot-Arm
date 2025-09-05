#! /usr/bin/env python

import sys
import rospy
import moveit_commander 
import tf
import moveit_msgs.msg
import geometry_msgs.msg
from geometry_msgs.msg import Pose,Point,PoseStamped
from tf.transformations import quaternion_from_euler
from tf import TransformListener
from ar_track_alvar_msgs.msg import AlvarMarkers
import copy
from moveit_commander import *
import actionlib
from control_msgs.msg import (GripperCommandAction,GripperCommandGoal)
from arm.srv import frameDev,frameDevRequest,frameDevResponse
from arm.srv import endEffectorPose,endEffectorPoseRequest
from moveit_msgs.msg import RobotTrajectory
from trajectory_msgs.msg import JointTrajectory,JointTrajectoryPoint
from control_msgs.msg import FollowJointTrajectoryAction
from control_msgs.msg import FollowJointTrajectoryGoal

mode = ""
item_num = ""
global marker
waypoints = []

def gripper_control(mode):
    gripper_joints=['ur_finger_left_joint','ur_finger_right_joint']
    if mode=="open":
        gripper_open_goal=[0.048,0.048]
    if mode=="close":
        gripper_open_goal=[0.03,0.03]
    gripper_client = actionlib.SimpleActionClient('/gripper_controller/follow_joint_trajectory',FollowJointTrajectoryAction)
    gripper_client.wait_for_server()

    gripper_traj = JointTrajectory()
    gripper_traj.joint_names = gripper_joints
    gripper_traj.points.append(JointTrajectoryPoint())
    gripper_traj.points[0].positions = gripper_open_goal
    gripper_traj.points[0].velocities = [0.0 for i in gripper_joints]
    gripper_traj.points[0].accelerations = [0.0 for i in gripper_joints]
    gripper_traj.points[0].time_from_start = rospy.Duration(3.0)

    gripper_goal = FollowJointTrajectoryGoal()
    gripper_goal.trajectory = gripper_traj
    gripper_goal.goal_time_tolerance = rospy.Duration(0.0)
    gripper_client.send_goal(gripper_goal)
    #gripper_client.wait_for_result(rospy.Duration(5.0))



def arm_move_group(mode,group_name="arm"):
    robot = moveit_commander.RobotCommander()
    scene = moveit_commander.PlanningSceneInterface()
    move_group = moveit_commander.MoveGroupCommander(group_name)

    move_group.allow_replanning(True)
    #display_trajectory_publisher = rospy.Publisher("/move_group/display_planned_path",moveit_msgs.msg.DisplayTrajectory)
    pose_target = Pose()

    if mode == "bin_pose": 
        pose_target.position.x = x  #+ 0.045
        pose_target.position.y = y - 0.04
        pose_target.position.z = z + 1.20
        q = quaternion_from_euler(-3.14, 0.0, 0)
        pose_target.orientation.x = q[0]
        pose_target.orientation.y = q[1]
        pose_target.orientation.z = q[2]
        pose_target.orientation.w = q[3]
        move_group.set_goal_tolerance(0.01) #This line is very important

        move_group.set_pose_target(pose_target)
        move_group.go(wait=False)

        move_group.stop()
    

    if mode == "home_pose":
        pose_target = "home_pose"
        move_group.set_goal_tolerance(0.02)
        move_group.set_named_target(pose_target)
        move_group.go(wait=False)
        move_group.stop()
    

    if mode == "adjust_pose":
        pose_targets = []
        req = endEffectorPoseRequest()
        req.checkPose = True

        current_pos_x = epose_serv(req).position_x
        current_pos_y = epose_serv(req).position_y
        current_pos_z = epose_serv(req).position_z
        current_orient_x = epose_serv(req).orientation_x
        current_orient_y = epose_serv(req).orientation_y
        current_orient_z = epose_serv(req).orientation_z
        current_orient_w = epose_serv(req).orientation_w

        pose_target = Pose()

        for i in range(4):
            pose_target.position.z = current_pos_z
            pose_target.position.y = current_pos_y - i*(y_err*0.0002)
            pose_target.position.x = current_pos_x - i*(x_err*0.0002)
            pose_target.orientation.x = current_orient_x
            pose_target.orientation.y = current_orient_y
            pose_target.orientation.z = current_orient_z
            pose_target.orientation.w = current_orient_w
        

        pose_targets.append(pose_target)

        print(pose_targets)

        for pose_target in pose_targets:
            move_group.set_pose_target(pose_target)
            move_group.go(wait=False)
        #rospy.sleep(2.0)

    if mode == "advance_pose":  
        #current_pose = move_group.get_current_pose().pose
        pose_targets = []
        #print(current_pose)
        req = endEffectorPoseRequest()
        req.checkPose = True

        current_pos_x = epose_serv(req).position_x
        current_pos_y = epose_serv(req).position_y
        current_pos_z = epose_serv(req).position_z
        current_orient_x = epose_serv(req).orientation_x
        current_orient_y = epose_serv(req).orientation_y
        current_orient_z = epose_serv(req).orientation_z
        current_orient_w = epose_serv(req).orientation_w

        pose_target = Pose()

        for i in range(5):
            pose_target.position.z = current_pos_z - i*0.054
            pose_target.position.y = current_pos_y
            pose_target.position.x = current_pos_x
            pose_target.orientation.x = current_orient_x
            pose_target.orientation.y = current_orient_y
            pose_target.orientation.z = current_orient_z
            pose_target.orientation.w = current_orient_w
        

        pose_targets.append(pose_target)

        print(pose_targets)
        move_group.set_goal_tolerance(0.01)

        for pose_target in pose_targets:
            move_group.set_pose_target(pose_target)
            move_group.go(wait=False)
        #rospy.sleep(2.0)
        #moveit_commander.roscpp_shutdown()


    if mode == "retrieve_pose":
               #current_pose = move_group.get_current_pose().pose
        pose_targets = []
        #print(current_pose)
        req = endEffectorPoseRequest()
        req.checkPose = True

        current_pos_x = epose_serv(req).position_x
        current_pos_y = epose_serv(req).position_y
        current_pos_z = epose_serv(req).position_z
        current_orient_x = epose_serv(req).orientation_x
        current_orient_y = epose_serv(req).orientation_y
        current_orient_z = epose_serv(req).orientation_z
        current_orient_w = epose_serv(req).orientation_w

        pose_target = Pose()

        for i in range(5):
            pose_target.position.z = current_pos_z + i*0.054
            pose_target.position.y = current_pos_y
            pose_target.position.x = current_pos_x
            pose_target.orientation.x = current_orient_x
            pose_target.orientation.y = current_orient_y
            pose_target.orientation.z = current_orient_z
            pose_target.orientation.w = current_orient_w
        

        pose_targets.append(pose_target)

        print(pose_targets)

        for pose_target in pose_targets:
            move_group.set_pose_target(pose_target)
            move_group.go(wait=False)


    move_group.clear_pose_targets()
    moveit_commander.roscpp_shutdown()


def tf_lookup(tf_listener, item_frame):
    try:
        (trans, rot) = tf_listener.lookupTransform('/urbase_link', item_frame, rospy.Time(0))
        return trans
    except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
        rospy.logerr("TF Exception")
        return None

def bin_pose():
    tf_listener = TransformListener()
    rospy.sleep(2.0)
    tf_values = tf_lookup(tf_listener, item_frame)
    binPose = True
    while tf_values is not None and binPose:
        global x,y,z
        x, y, z = tf_values[0], tf_values[1], tf_values[2]
        rospy.loginfo("TAG_%s offset position: [%f, %f, %f]",item_num, x, y, z)
        #arm_move_group(mode="bin_pose",group_name="arm")
        break
    binPose = False
    #global x,y,z
    #x,y,z = a,b,c
    #arm_move_group(mode="bin_pose",group_name="arm")
        

def gripper_open():
    gripper_goal.command.position = 0.048
    gripper_goal.command.max_effort = 5
    gripper.send_goal(gripper_goal)
    gripper.wait_for_result(rospy.Duration(1.0))

def gripper_close():
    gripper_goal.command.position = 0.03
    gripper_goal.command.max_effort = 20
    gripper.send_goal(gripper_goal)
    gripper.wait_for_result(rospy.Duration(1.0))
   
def adjust_pose(color):
    req = frameDevRequest()
    req.color = color
    print("To pick Item of color " + color)
    check = True
    while check:
        try:
            x_val = dev_serv(req).x_dev
            y_val = dev_serv(req).y_dev
            #print("x_deviation: ",x_val)
            #print("y_deviation: ",y_val)
            while check:
                print("waiting")
                x_val = dev_serv(req).x_dev 
                y_val = dev_serv(req).y_dev   

                if dev_serv.call(req):
                    rospy.sleep(1.0)
                    x_val = dev_serv(req).x_dev 
                    y_val = dev_serv(req).y_dev 
                    print("Adjusting arm pose in x axis by " + str(x_val)+"\n")
                    print("Adjusting arm pose in y axis by " + str(y_val)+"\n")
                    global x_err
                    global y_err
                    desired_x_dev = 0
                    desired_y_dev = -107
                    x_err = (x_val) - desired_x_dev
                    y_err = desired_y_dev - (y_val)
                    arm_move_group(mode = "adjust_pose")
                    #req.color = "none"
                    #dev_serv.call(req)
                    check = False
                    break
        except:
            #print("Object not found")
            check = True
            #if KeyboardInterrupt:
            #    return None

if __name__ == '__main__':
    rospy.init_node('move_group_program')
    
    gripper = actionlib.SimpleActionClient("gripper_controller/gripper_cmd",GripperCommandAction)
    gripper_goal = GripperCommandGoal()
    #gripper.wait_for_server()
    #gripper.wait_for_server(rospy.Duration(5.0))

    dev_serv = rospy.ServiceProxy('/camera_frame_deviation',frameDev)
    dev_serv.wait_for_service()

    epose_serv = rospy.ServiceProxy('/end_effector_pose',endEffectorPose)
    epose_serv.wait_for_service()

    #tf_listener = TransformListener()

    if len(sys.argv) != 2:
        rospy.logerr("Usage: python script_name.py MODE; p to pick item at specificied location, d to drop item at specificied location #")
        sys.exit(1)

    if sys.argv[1] == "p":
        mode = "pick_item"
        item_num = str(input("Enter TAG number to pick Item: \n "))
        item_frame = "item_" + item_num
        color_num = int(input("What color of Object do you want to pick 0 for Red, 1 for Green: \n" ))
        global color
        if color_num == 0:
            color = "red"
        if color_num == 1:
            color = "green"

    if sys.argv[1] == "d":
        mode = "drop_item"
        item_num = str(input("Enter TAG number to drop Item: \n"))
        item_frame = "item_" + item_num


    while not rospy.is_shutdown():
        if mode == "pick_item":
            req = frameDevRequest()
            #color = "red"
            print(color)
            rospy.loginfo("Executing pick item actions...")
            
            rospy.loginfo("Moving to Home Position...")
            #arm_move_group(mode="home_pose")
            #rospy.sleep(5.0)
            rospy.loginfo("Opening Gripper...")
            gripper_control("open")
            rospy.loginfo("Moving to Item location...")
            bin_pose()
            rospy.sleep(3.0)
            arm_move_group(mode="bin_pose",group_name="arm")
            rospy.sleep(3.0)
            rospy.loginfo("Adjusting arm position...")
            rospy.sleep(1.0)
            adjust_pose(color)
            rospy.sleep(3.0)           
            rospy.loginfo("Advancing towards item...")
            arm_move_group("advance_pose")
            rospy.sleep(3.0)
            rospy.loginfo("Closing Gripper and Grasping item...")
            gripper_control("close")
            rospy.sleep(5.0)
            #rospy.loginfo("Retrieving...")
            #arm_move_group("retrieve_pose")
            #rospy.sleep(3.0)
            rospy.loginfo("Moving to Home Position...")
            arm_move_group(mode="home_pose")
            rospy.sleep(2.0)
            req.color = "none"
            dev_serv.call(req)
            break

        if mode == "drop_item":
            rospy.loginfo("Moving to location...")
            bin_pose()
            rospy.sleep(3.0)
            arm_move_group(mode="bin_pose",group_name="arm")
            rospy.sleep(3.0)           
            #rospy.loginfo("Advancing...")
            #arm_move_group("advance_pose")
            #rospy.sleep(3.0)
            rospy.loginfo("Opening Gripper and Releasing item...")
            gripper_control("open")
            rospy.sleep(2.0)
            #rospy.loginfo("Retrieving...")
            #arm_move_group("retrieve_pose")
            #rospy.sleep(3.0)
            rospy.loginfo("Closing Gripper...")
            gripper_control("close")
            rospy.loginfo("Moving to Home Position...")
            arm_move_group(mode="home_pose")
            rospy.sleep(2.0)
            break
        
        
        rospy.sleep(2)