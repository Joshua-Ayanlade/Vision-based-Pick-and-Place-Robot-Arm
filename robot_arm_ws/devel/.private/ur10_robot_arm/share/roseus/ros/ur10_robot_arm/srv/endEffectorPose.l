;; Auto-generated. Do not edit!


(when (boundp 'ur10_robot_arm::endEffectorPose)
  (if (not (find-package "UR10_ROBOT_ARM"))
    (make-package "UR10_ROBOT_ARM"))
  (shadow 'endEffectorPose (find-package "UR10_ROBOT_ARM")))
(unless (find-package "UR10_ROBOT_ARM::ENDEFFECTORPOSE")
  (make-package "UR10_ROBOT_ARM::ENDEFFECTORPOSE"))
(unless (find-package "UR10_ROBOT_ARM::ENDEFFECTORPOSEREQUEST")
  (make-package "UR10_ROBOT_ARM::ENDEFFECTORPOSEREQUEST"))
(unless (find-package "UR10_ROBOT_ARM::ENDEFFECTORPOSERESPONSE")
  (make-package "UR10_ROBOT_ARM::ENDEFFECTORPOSERESPONSE"))

(in-package "ROS")





(defclass ur10_robot_arm::endEffectorPoseRequest
  :super ros::object
  :slots (_checkPose ))

(defmethod ur10_robot_arm::endEffectorPoseRequest
  (:init
   (&key
    ((:checkPose __checkPose) nil)
    )
   (send-super :init)
   (setq _checkPose __checkPose)
   self)
  (:checkPose
   (&optional __checkPose)
   (if __checkPose (setq _checkPose __checkPose)) _checkPose)
  (:serialization-length
   ()
   (+
    ;; bool _checkPose
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _checkPose
       (if _checkPose (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _checkPose
     (setq _checkPose (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass ur10_robot_arm::endEffectorPoseResponse
  :super ros::object
  :slots (_position_x _position_y _position_z _orientation_x _orientation_y _orientation_z _orientation_w ))

(defmethod ur10_robot_arm::endEffectorPoseResponse
  (:init
   (&key
    ((:position_x __position_x) 0.0)
    ((:position_y __position_y) 0.0)
    ((:position_z __position_z) 0.0)
    ((:orientation_x __orientation_x) 0.0)
    ((:orientation_y __orientation_y) 0.0)
    ((:orientation_z __orientation_z) 0.0)
    ((:orientation_w __orientation_w) 0.0)
    )
   (send-super :init)
   (setq _position_x (float __position_x))
   (setq _position_y (float __position_y))
   (setq _position_z (float __position_z))
   (setq _orientation_x (float __orientation_x))
   (setq _orientation_y (float __orientation_y))
   (setq _orientation_z (float __orientation_z))
   (setq _orientation_w (float __orientation_w))
   self)
  (:position_x
   (&optional __position_x)
   (if __position_x (setq _position_x __position_x)) _position_x)
  (:position_y
   (&optional __position_y)
   (if __position_y (setq _position_y __position_y)) _position_y)
  (:position_z
   (&optional __position_z)
   (if __position_z (setq _position_z __position_z)) _position_z)
  (:orientation_x
   (&optional __orientation_x)
   (if __orientation_x (setq _orientation_x __orientation_x)) _orientation_x)
  (:orientation_y
   (&optional __orientation_y)
   (if __orientation_y (setq _orientation_y __orientation_y)) _orientation_y)
  (:orientation_z
   (&optional __orientation_z)
   (if __orientation_z (setq _orientation_z __orientation_z)) _orientation_z)
  (:orientation_w
   (&optional __orientation_w)
   (if __orientation_w (setq _orientation_w __orientation_w)) _orientation_w)
  (:serialization-length
   ()
   (+
    ;; float32 _position_x
    4
    ;; float32 _position_y
    4
    ;; float32 _position_z
    4
    ;; float32 _orientation_x
    4
    ;; float32 _orientation_y
    4
    ;; float32 _orientation_z
    4
    ;; float32 _orientation_w
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _position_x
       (sys::poke _position_x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _position_y
       (sys::poke _position_y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _position_z
       (sys::poke _position_z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _orientation_x
       (sys::poke _orientation_x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _orientation_y
       (sys::poke _orientation_y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _orientation_z
       (sys::poke _orientation_z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _orientation_w
       (sys::poke _orientation_w (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _position_x
     (setq _position_x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _position_y
     (setq _position_y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _position_z
     (setq _position_z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _orientation_x
     (setq _orientation_x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _orientation_y
     (setq _orientation_y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _orientation_z
     (setq _orientation_z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _orientation_w
     (setq _orientation_w (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass ur10_robot_arm::endEffectorPose
  :super ros::object
  :slots ())

(setf (get ur10_robot_arm::endEffectorPose :md5sum-) "ab49f52154a9a8f037faf1e645e24d47")
(setf (get ur10_robot_arm::endEffectorPose :datatype-) "ur10_robot_arm/endEffectorPose")
(setf (get ur10_robot_arm::endEffectorPose :request) ur10_robot_arm::endEffectorPoseRequest)
(setf (get ur10_robot_arm::endEffectorPose :response) ur10_robot_arm::endEffectorPoseResponse)

(defmethod ur10_robot_arm::endEffectorPoseRequest
  (:response () (instance ur10_robot_arm::endEffectorPoseResponse :init)))

(setf (get ur10_robot_arm::endEffectorPoseRequest :md5sum-) "ab49f52154a9a8f037faf1e645e24d47")
(setf (get ur10_robot_arm::endEffectorPoseRequest :datatype-) "ur10_robot_arm/endEffectorPoseRequest")
(setf (get ur10_robot_arm::endEffectorPoseRequest :definition-)
      "bool checkPose
---
float32 position_x
float32 position_y
float32 position_z
float32 orientation_x
float32 orientation_y
float32 orientation_z
float32 orientation_w

")

(setf (get ur10_robot_arm::endEffectorPoseResponse :md5sum-) "ab49f52154a9a8f037faf1e645e24d47")
(setf (get ur10_robot_arm::endEffectorPoseResponse :datatype-) "ur10_robot_arm/endEffectorPoseResponse")
(setf (get ur10_robot_arm::endEffectorPoseResponse :definition-)
      "bool checkPose
---
float32 position_x
float32 position_y
float32 position_z
float32 orientation_x
float32 orientation_y
float32 orientation_z
float32 orientation_w

")



(provide :ur10_robot_arm/endEffectorPose "ab49f52154a9a8f037faf1e645e24d47")


