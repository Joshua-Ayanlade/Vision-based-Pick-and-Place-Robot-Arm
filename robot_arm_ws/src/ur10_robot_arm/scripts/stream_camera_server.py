#!/usr/bin/env python
import rospy
import cv2 as cv
import numpy as np
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError
from arm.srv import frameDev,frameDevResponse,frameDevRequest

class ObjectDetection(object):
    def __init__(self):
        self.image_sub = rospy.Subscriber("/gripper_kinect/gripper/rgb/image_raw", Image, self.camera_callback)
        self.server = rospy.Service('/camera_frame_deviation',frameDev,self.frame_dev)
        self.bridge_object = CvBridge()
        self.color ="none"
        self.check = False


    def camera_callback(self, data):
        try:
            self.cv_image = self.bridge_object.imgmsg_to_cv2(data, desired_encoding="bgr8")
        except CvBridgeError as e:
            print(e)
            
        self.hsv = cv.cvtColor(self.cv_image, cv.COLOR_BGR2HSV)
        min_green_f = np.array([60, 251, 124])
        max_green_f = np.array([61, 255, 135])
        min_green_t = np.array([60, 135, 124])
        max_green_t = np.array([61, 255, 255])

        min_red_f = np.array([0, 223, 102])
        max_red_f = np.array([0, 255, 244])
        min_red_t = np.array([0, 233, 224])
        max_red_t = np.array([0, 251, 255])



        if self.color == "red":
            self.edge_detection(min_red_t,max_red_t)
        if self.color == "green":
            self.edge_detection(min_green_t,max_green_t)
        if self.color == "none":
            cv.destroyAllWindows()
        else:
            return None
        

    def edge_detection(self,hsv_min,hsv_max):

        h_frame,w_frame,d_frame = self.cv_image.shape

        mask_r = cv.inRange(self.hsv, hsv_min, hsv_max)
        #res_r = cv.bitwise_and(cv_image, cv_image, mask = mask_r)
        mask = cv.adaptiveThreshold(mask_r, 255, cv.ADAPTIVE_THRESH_MEAN_C, cv.THRESH_BINARY_INV, 3, 3)
        #cv.imshow("mask", mask)

        # find contours
        contours, _ = cv.findContours(mask, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)[-2:]
        #print("contours: ", contours)

        for cnt in contours:
            cv.polylines(self.cv_image, [cnt], True, [255, 0, 0], 1)

        object_detected = []

        for cnt in contours:
            area = cv.contourArea(cnt)
            if area > 20:
                cnt = cv.approxPolyDP(cnt, 0.03*cv.arcLength(cnt, True), True)
                object_detected.append(cnt)
        
        #print("how many object I detect: ", len(object_detected))
        #print(object_detected)

        for cnt in object_detected:
            rect = cv.minAreaRect(cnt)
            (x_center, y_center), (w,h), orientation = rect
            x_dev,y_dev = w_frame//2 - x_center,h_frame//2-y_center
            self.x_dev = x_dev
            self.y_dev = y_dev
            #print("width = ", w)
            #print("heigh = ", h)
            box = cv.boxPoints(rect)
            box = np.int0(box)
            cv.polylines(self.cv_image, [box], True, (255, 0,0),1)
            cv.putText(self.cv_image, "x: {}".format(round(x_center, 1)) + " y: {}".format(round(y_center,1)), (int(x_center), int(y_center)), cv.FONT_HERSHEY_PLAIN, 1, (255,0,0),2)
            cv.putText(self.cv_image, "x_dev: {}".format(round(self.x_dev, 1)) + " y_dev: {}".format(round(self.y_dev,1)), (10, 20), cv.FONT_HERSHEY_DUPLEX, 1, (255,0,0),2)

            cv.circle(self.cv_image, (int(x_center), int(y_center)), 1, (255,0,0), thickness=-1)

        self.check = True
        res = frameDevResponse()
        res.x_dev = self.x_dev
        res.y_dev = self.y_dev


        #cv.imshow("cropped", cropped_img)
        cv.namedWindow("object detection",cv.WINDOW_KEEPRATIO)
        cv.resizeWindow("object detection",400,300)
        cv.imshow("object detection", self.cv_image)
        cv.waitKey(1)

    def frame_dev(self,req):
        self.color = str(req.color)
        #print(self.color)
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
