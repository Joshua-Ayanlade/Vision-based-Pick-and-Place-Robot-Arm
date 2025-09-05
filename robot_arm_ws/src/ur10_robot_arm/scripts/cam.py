#!/usr/bin/env python
import rospy
import sys,os
import cv2
from cv_bridge import CvBridge,CvBridgeError
from sensor_msgs.msg import Image

class Camera(object):
    def __init__(self):
        self.sub = rospy.Subscriber('/gripper_kinect/gripper/rgb/image_raw',Image,self.camera_callback)
        self.bridge = CvBridge()
    
    def camera_callback(self,msg):
        try:
            cv_image = self.bridge.imgmsg_to_cv2(msg,desired_encoding="bgr8")

        except CvBridgeError as e:
            print(e)

        file_path = '/home/vboxuser/cpp_ros/src/arm/ur10_w_gripper/images/'
        #assert os.path.isfile(file_path)
        cv2.imwrite(file_path+'image_red.png',cv_image)
        cv2.imshow('window',cv_image)
        cv2.waitKey(0)

def main():
    camera = Camera()
    rospy.init_node('write_image_node', anonymous=True)
    try:
        rospy.spin()
    except KeyboardInterrupt:
        print("Shutting down")
    cv2.destroyAllWindows()

if __name__ == '__main__':
    main()

