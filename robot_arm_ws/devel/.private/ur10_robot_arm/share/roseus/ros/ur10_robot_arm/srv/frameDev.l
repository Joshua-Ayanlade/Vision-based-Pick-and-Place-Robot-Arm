;; Auto-generated. Do not edit!


(when (boundp 'ur10_robot_arm::frameDev)
  (if (not (find-package "UR10_ROBOT_ARM"))
    (make-package "UR10_ROBOT_ARM"))
  (shadow 'frameDev (find-package "UR10_ROBOT_ARM")))
(unless (find-package "UR10_ROBOT_ARM::FRAMEDEV")
  (make-package "UR10_ROBOT_ARM::FRAMEDEV"))
(unless (find-package "UR10_ROBOT_ARM::FRAMEDEVREQUEST")
  (make-package "UR10_ROBOT_ARM::FRAMEDEVREQUEST"))
(unless (find-package "UR10_ROBOT_ARM::FRAMEDEVRESPONSE")
  (make-package "UR10_ROBOT_ARM::FRAMEDEVRESPONSE"))

(in-package "ROS")





(defclass ur10_robot_arm::frameDevRequest
  :super ros::object
  :slots (_color ))

(defmethod ur10_robot_arm::frameDevRequest
  (:init
   (&key
    ((:color __color) "")
    )
   (send-super :init)
   (setq _color (string __color))
   self)
  (:color
   (&optional __color)
   (if __color (setq _color __color)) _color)
  (:serialization-length
   ()
   (+
    ;; string _color
    4 (length _color)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _color
       (write-long (length _color) s) (princ _color s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _color
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _color (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass ur10_robot_arm::frameDevResponse
  :super ros::object
  :slots (_x_dev _y_dev ))

(defmethod ur10_robot_arm::frameDevResponse
  (:init
   (&key
    ((:x_dev __x_dev) 0)
    ((:y_dev __y_dev) 0)
    )
   (send-super :init)
   (setq _x_dev (round __x_dev))
   (setq _y_dev (round __y_dev))
   self)
  (:x_dev
   (&optional __x_dev)
   (if __x_dev (setq _x_dev __x_dev)) _x_dev)
  (:y_dev
   (&optional __y_dev)
   (if __y_dev (setq _y_dev __y_dev)) _y_dev)
  (:serialization-length
   ()
   (+
    ;; int32 _x_dev
    4
    ;; int32 _y_dev
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _x_dev
       (write-long _x_dev s)
     ;; int32 _y_dev
       (write-long _y_dev s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _x_dev
     (setq _x_dev (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _y_dev
     (setq _y_dev (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass ur10_robot_arm::frameDev
  :super ros::object
  :slots ())

(setf (get ur10_robot_arm::frameDev :md5sum-) "a3a39a6de41cd121631db316fe36d1b6")
(setf (get ur10_robot_arm::frameDev :datatype-) "ur10_robot_arm/frameDev")
(setf (get ur10_robot_arm::frameDev :request) ur10_robot_arm::frameDevRequest)
(setf (get ur10_robot_arm::frameDev :response) ur10_robot_arm::frameDevResponse)

(defmethod ur10_robot_arm::frameDevRequest
  (:response () (instance ur10_robot_arm::frameDevResponse :init)))

(setf (get ur10_robot_arm::frameDevRequest :md5sum-) "a3a39a6de41cd121631db316fe36d1b6")
(setf (get ur10_robot_arm::frameDevRequest :datatype-) "ur10_robot_arm/frameDevRequest")
(setf (get ur10_robot_arm::frameDevRequest :definition-)
      "string color

---

int32 x_dev
int32 y_dev

")

(setf (get ur10_robot_arm::frameDevResponse :md5sum-) "a3a39a6de41cd121631db316fe36d1b6")
(setf (get ur10_robot_arm::frameDevResponse :datatype-) "ur10_robot_arm/frameDevResponse")
(setf (get ur10_robot_arm::frameDevResponse :definition-)
      "string color

---

int32 x_dev
int32 y_dev

")



(provide :ur10_robot_arm/frameDev "a3a39a6de41cd121631db316fe36d1b6")


