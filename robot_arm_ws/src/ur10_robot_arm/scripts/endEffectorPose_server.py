#!/usr/bin/env python
import rospy
from arm.srv import endEffectorPose,endEffectorPoseResponse
import moveit_commander
import moveit_msgs.msg
import geometry_msgs.msg
from geometry_msgs.msg import Pose,Point,PoseStamped
from moveit_commander import *

class endEffectorPoses:
    def __init__(self):
        self.server = rospy.Service('/end_effector_pose',endEffectorPose,self.pose_callback)
        self.pose_target = Pose()

    def arm_move_group(self):
        robot = moveit_commander.RobotCommander()
        scene = moveit_commander.PlanningSceneInterface()
        move_group = moveit_commander.MoveGroupCommander("arm")
        current_pose = move_group.get_current_pose().pose
        self.pose_target.position.x = current_pose.position.x
        self.pose_target.position.y = current_pose.position.y
        self.pose_target.position.z = current_pose.position.z
        self.pose_target.orientation.x = current_pose.orientation.x
        self.pose_target.orientation.y = current_pose.orientation.y
        self.pose_target.orientation.z = current_pose.orientation.z
        self.pose_target.orientation.w = current_pose.orientation.w

    def pose_callback(self,req):
        self.arm_move_group()
        if req:
            res = endEffectorPoseResponse()
            res.position_x = self.pose_target.position.x
            res.position_y = self.pose_target.position.y
            res.position_z = self.pose_target.position.z
            res.orientation_x = self.pose_target.orientation.x
            res.orientation_y = self.pose_target.orientation.y
            res.orientation_z = self.pose_target.orientation.z
            res.orientation_w = self.pose_target.orientation.w
        return res
            
if __name__ == '__main__':
    end_effector_pose = endEffectorPoses()
    rospy.init_node('end_effector_poses',anonymous=True)
    try:
        rospy.spin()
    except KeyboardInterrupt:
        print("Shutting down")
