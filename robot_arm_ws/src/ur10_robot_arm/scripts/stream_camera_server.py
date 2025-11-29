#!/usr/bin/env python
import rospy
import cv2 as cv
import numpy as np
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError
from ur10_robot_arm.srv import frameDev,frameDevResponse,frameDevRequest

class ObjectDetection(object):
    def __init__(self):
        # Wait for parameters to be set
        rospy.sleep(1.0)
        
        self.image_sub = rospy.Subscriber("/gripper_kinect/gripper/rgb/image_raw", Image, self.camera_callback)
        self.server = rospy.Service('/camera_frame_deviation',frameDev,self.frame_dev)
        self.bridge_object = CvBridge()
        self.color ="none"
        self.check = False
        
        # Load available colors and HSV ranges from ROS parameter server
        self.available_colors = []
        self.hsv_ranges = {}
        self.load_parameters()
        
        rospy.loginfo("Object detection initialized for colors: %s", self.available_colors)

    def load_parameters(self):
        """Load colors and HSV ranges from ROS parameters"""
        # Get available colors
        if rospy.has_param('/colors'):
            self.available_colors = rospy.get_param('/colors')
            rospy.loginfo("Loaded available colors: %s", self.available_colors)
        else:
            rospy.logerr("No colors parameter found! Please run ChatGPT node first.")
            return
        
        # Load HSV ranges for each color
        for color in self.available_colors:
            min_key = '/hsv_ranges/' + color + '/min'
            max_key = '/hsv_ranges/' + color + '/max'
            
            if rospy.has_param(min_key) and rospy.has_param(max_key):
                min_hsv = rospy.get_param(min_key)
                max_hsv = rospy.get_param(max_key)
                
                self.hsv_ranges[color] = {
                    'min': np.array(min_hsv),
                    'max': np.array(max_hsv)
                }
                rospy.loginfo("Loaded HSV for %s: min=%s, max=%s", color, min_hsv, max_hsv)
            else:
                rospy.logerr("HSV parameters not found for color: %s", color)

    def camera_callback(self, data):
        try:
            self.cv_image = self.bridge_object.imgmsg_to_cv2(data, desired_encoding="bgr8")
        except CvBridgeError as e:
            print(e)
            
        self.hsv = cv.cvtColor(self.cv_image, cv.COLOR_BGR2HSV)

        # Use dynamic HSV ranges from parameters
        if self.color in self.hsv_ranges:
            hsv_range = self.hsv_ranges[self.color]
            self.edge_detection(hsv_range['min'], hsv_range['max'])
        elif self.color == "none":
            cv.destroyAllWindows()
        else:
            rospy.logwarn("No HSV range defined for color: %s", self.color)
            rospy.logwarn("Available colors: %s", list(self.hsv_ranges.keys()))
            return None
        

    def edge_detection(self,hsv_min,hsv_max):
        h_frame,w_frame,d_frame = self.cv_image.shape

        mask_r = cv.inRange(self.hsv, hsv_min, hsv_max)
        mask = cv.adaptiveThreshold(mask_r, 255, cv.ADAPTIVE_THRESH_MEAN_C, cv.THRESH_BINARY_INV, 3, 3)

        # find contours
        contours, _ = cv.findContours(mask, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)[-2:]

        for cnt in contours:
            cv.polylines(self.cv_image, [cnt], True, [255, 0, 0], 1)

        object_detected = []

        for cnt in contours:
            area = cv.contourArea(cnt)
            if area > 20:
                cnt = cv.approxPolyDP(cnt, 0.03*cv.arcLength(cnt, True), True)
                object_detected.append(cnt)
        
        for cnt in object_detected:
            rect = cv.minAreaRect(cnt)
            (x_center, y_center), (w,h), orientation = rect
            x_dev,y_dev = w_frame//2 - x_center,h_frame//2-y_center
            self.x_dev = x_dev
            self.y_dev = y_dev

            box = cv.boxPoints(rect)
            box = np.int0(box)
            cv.polylines(self.cv_image, [box], True, (255, 0,0),1)
            cv.putText(self.cv_image, "x: {}".format(round(x_center, 1)) + " y: {}".format(round(y_center,1)), (int(x_center), int(y_center)), cv.FONT_HERSHEY_PLAIN, 1, (255,0,0),2)
            cv.putText(self.cv_image, "x_dev: {}".format(round(self.x_dev, 1)) + " y_dev: {}".format(round(self.y_dev,1)), (10, 20), cv.FONT_HERSHEY_DUPLEX, 1, (255,0,0),2)

            cv.circle(self.cv_image, (int(x_center), int(y_center)), 1, (255,0,0), thickness=-1)

        self.check = True

        cv.namedWindow("object detection",cv.WINDOW_KEEPRATIO)
        cv.resizeWindow("object detection",400,300)
        cv.imshow("object detection", self.cv_image)
        cv.waitKey(1)

    def frame_dev(self,req):
        self.color = str(req.color)
        # Validate that the requested color is available
        if self.color != "none" and self.color not in self.available_colors:
            rospy.logwarn("Requested color '%s' not in available colors: %s", self.color, self.available_colors)
            res = frameDevResponse()
            res.x_dev = 0.0
            res.y_dev = 0.0
            return res
            
        if req and self.check==True:
            res = frameDevResponse()
            res.x_dev = self.x_dev
            res.y_dev = self.y_dev
            return res


if __name__ == '__main__':
    object_detection = ObjectDetection() 
    rospy.init_node('object_detection', anonymous=True)
    try:
        rospy.spin()
    except KeyboardInterrupt:
        print("Shutting down")
    cv.destroyAllWindows()




