#! /usr/bin/env python

import sys
import rospy
import moveit_commander 
import tf
import moveit_msgs.msg
import geometry_msgs.msg
from geometry_msgs.msg import Pose, Point, PoseStamped
from tf.transformations import quaternion_from_euler
from tf import TransformListener
from ar_track_alvar_msgs.msg import AlvarMarkers
import copy
from moveit_commander import *
import actionlib
from control_msgs.msg import (GripperCommandAction, GripperCommandGoal)
from ur10_robot_arm.srv import frameDev, frameDevRequest, frameDevResponse
from ur10_robot_arm.srv import endEffectorPose, endEffectorPoseRequest
from moveit_msgs.msg import RobotTrajectory
from trajectory_msgs.msg import JointTrajectory, JointTrajectoryPoint
from control_msgs.msg import FollowJointTrajectoryAction
from control_msgs.msg import FollowJointTrajectoryGoal
import actionlib_msgs.msg

mode = ""
item_num = ""
global marker
waypoints = []

global last_execution_status
last_execution_status = None

def trajectory_status_callback(msg):
    global last_execution_status
    if msg.status_list:
        latest_status = msg.status_list[-1]
        last_execution_status = latest_status.status
    return last_execution_status


def gripper_control(mode):
    gripper_joints = ['ur_finger_left_joint', 'ur_finger_right_joint']
    if mode == "open":
        gripper_open_goal = [0.048, 0.048]
    if mode == "close":
        gripper_open_goal = [0.03, 0.03]
    
    gripper_client = actionlib.SimpleActionClient('/gripper_controller/follow_joint_trajectory', FollowJointTrajectoryAction)
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
    gripper_client.wait_for_result(rospy.Duration(5.0))
    return gripper_client.get_state() == actionlib.GoalStatus.SUCCEEDED

def arm_move_group(mode, group_name="arm", wait=True):
    robot = moveit_commander.RobotCommander()
    scene = moveit_commander.PlanningSceneInterface()
    move_group = moveit_commander.MoveGroupCommander(group_name)
    status_sub = rospy.Subscriber('/move_group/status', actionlib_msgs.msg.GoalStatusArray, trajectory_status_callback)

    move_group.allow_replanning(True)
    success = False
    last_execution_status = None

    if mode == "bin_pose": 
        pose_target = Pose()
        pose_target.position.x = x  # + 0.045
        pose_target.position.y = y - 0.04
        pose_target.position.z = z + 1.20
        q = quaternion_from_euler(-3.14, 0.0, 0)
        pose_target.orientation.x = q[0]
        pose_target.orientation.y = q[1]
        pose_target.orientation.z = q[2]
        pose_target.orientation.w = q[3]
        move_group.set_goal_tolerance(0.01)

        move_group.set_pose_target(pose_target)
        success = move_group.go(wait=wait)
        if wait:
            move_group.stop()

        if last_execution_status is not None:
                status_str = actionlib_msgs.msg.GoalStatus.to_string(last_execution_status)
                rospy.loginfo("Final trajectory execution status: %s", status_str)
                return status_str

    elif mode == "home_pose":
        pose_target = "home_pose"
        move_group.set_goal_tolerance(0.02)
        move_group.set_named_target(pose_target)
        success = move_group.go(wait=wait)
        if wait:
            move_group.stop()

    elif mode == "adjust_pose":
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
            pose_target.position.y = current_pos_y - i * (y_err * 0.0002)
            pose_target.position.x = current_pos_x - i * (x_err * 0.0002)
            pose_target.orientation.x = current_orient_x
            pose_target.orientation.y = current_orient_y
            pose_target.orientation.z = current_orient_z
            pose_target.orientation.w = current_orient_w

        pose_targets.append(pose_target)

        print(pose_targets)

        for pose_target in pose_targets:
            move_group.set_pose_target(pose_target)
            success = move_group.go(wait=wait)
            if not success:
                break

    elif mode == "advance_pose":  
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

        for i in range(5):
            pose_target.position.z = current_pos_z - i * 0.054
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
            success = move_group.go(wait=wait)
            if not success:
                break

    elif mode == "retrieve_pose":
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

        for i in range(5):
            pose_target.position.z = current_pos_z + i * 0.054
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
            success = move_group.go(wait=wait)
            if not success:
                break

    if wait:
        move_group.clear_pose_targets()
    
    return success

def tf_lookup(tf_listener, item_frame):
    try:
        (trans, rot) = tf_listener.lookupTransform('/urbase_link', item_frame, rospy.Time(0))
        return trans
    except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
        rospy.logerr("TF Exception")
        return None

def bin_pose():
    """Get bin pose and move to it"""
    tf_listener = TransformListener()
    rospy.sleep(2.0)
    tf_values = tf_lookup(tf_listener, item_frame)
    
    if tf_values is not None:
        global x, y, z
        x, y, z = tf_values[0], tf_values[1], tf_values[2]
        rospy.loginfo("TAG_%s offset position: [%f, %f, %f]", item_num, x, y, z)
        
        # Move towards the bin
        success = arm_move_group(mode="bin_pose", group_name="arm", wait=True)
        if success:
            rospy.loginfo("Successfully moved to bin pose")
        else:
            rospy.logerr("Failed to move to bin pose")
        return success
    else:
        rospy.logerr("Could not get TF transform for item frame: %s", item_frame)
        return False


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
            check = True


def execute_pick_sequence():
    """Execute pick sequence without hardcoded delays"""
    req = frameDevRequest()
    rospy.loginfo("Executing pick item actions...")
    
    #Move to Home Position
    rospy.loginfo("Moving to Home Position...")
    if not arm_move_group(mode="home_pose", wait=True):
        rospy.logerr("Failed to move to home pose")
        return False
    
    #Open Gripper
    rospy.loginfo("Opening Gripper...")
    if not gripper_control("open"):
        rospy.logwarn("Gripper open had issues, but continuing...")
    
    #Move to Item Location
    rospy.loginfo("Moving to Item location...")

    binPose = True
    while binPose:
        status = bin_pose()
        print(status)
        if not status or status:
            binPose = False

    
    #Adjust Position
    rospy.loginfo("Adjusting arm position...")
    adjust_pose(color) 
    
    #Advance Towards Item
    rospy.loginfo("Advancing towards item...")
    if not arm_move_group("advance_pose", wait=True):
        pass

    
    #Close Gripper
    rospy.loginfo("Closing Gripper and Grasping item...")
    rospy.sleep(1.0)
    if not gripper_control("close"):
        rospy.logwarn("Gripper close had issues, but continuing...")
    
    # Step 7: Return to Home
    rospy.loginfo("Moving to Home Position...")
    if not arm_move_group(mode="home_pose", wait=True):
        rospy.logerr("Failed to return to home pose")
        return False
    

    req.color = "none"
    try:
        dev_serv.call(req)
    except:
        pass
        
    rospy.loginfo("Pick sequence completed successfully")
    return True

def execute_drop_sequence():
    rospy.loginfo("Moving to drop location...")
    binPose = True
    while binPose:
        status = bin_pose()
        print(status)
        if not status or status:
            binPose = False
    
    rospy.loginfo("Opening Gripper and Releasing item...")
    if not gripper_control("open"):
        rospy.logwarn("Gripper open had issues but continuing...")
    
    rospy.loginfo("Closing Gripper...")
    if not gripper_control("close"):
        rospy.logwarn("Gripper close had issues but continuing...")
    
    rospy.loginfo("Moving to Home Position...")
    if not arm_move_group(mode="home_pose", wait=True):
        rospy.logerr("Failed to return to home pose")
        return False
    
    rospy.loginfo("Drop sequence completed successfully")
    return True

if __name__ == '__main__':
    rospy.init_node('move_group_program')
    
    gripper = actionlib.SimpleActionClient("gripper_controller/gripper_cmd", GripperCommandAction)
    gripper_goal = GripperCommandGoal()

    dev_serv = rospy.ServiceProxy('/camera_frame_deviation', frameDev)
    dev_serv.wait_for_service()

    epose_serv = rospy.ServiceProxy('/end_effector_pose', endEffectorPose)
    epose_serv.wait_for_service()

    if len(sys.argv) != 2:
        rospy.logerr("Usage: python script_name.py MODE: enter p to pick item at specificied location, d to drop item at specificied location #")
        sys.exit(1)

    if sys.argv[1] == "p":
        mode = "pick_item"
        item_num = str(input("Enter TAG number to pick Item: \n "))
        item_frame = "item_" + item_num
        color_input = str(raw_input("What color of Object do you want to pick? \n")).lower() 
        color = color_input

    if sys.argv[1] == "d":
        mode = "drop_item"
        item_num = str(input("Enter TAG number to drop Item: \n"))
        item_frame = "item_" + item_num

    while not rospy.is_shutdown():
        if mode == "pick_item":
            if execute_pick_sequence():
                rospy.loginfo("PICK OPERATION COMPLETED")
            else:
                rospy.logerr("PICK OPERATION FAILED")
            break

        if mode == "drop_item":
            if execute_drop_sequence():
                rospy.loginfo("DROP OPERATION COMPLETED")
            else:
                rospy.logerr("DROP OPERATION FAILED")
            break
        
        rospy.sleep(1)