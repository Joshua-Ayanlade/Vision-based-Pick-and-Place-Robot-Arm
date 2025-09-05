; Auto-generated. Do not edit!


(cl:in-package ur10_robot_arm-srv)


;//! \htmlinclude endEffectorPose-request.msg.html

(cl:defclass <endEffectorPose-request> (roslisp-msg-protocol:ros-message)
  ((checkPose
    :reader checkPose
    :initarg :checkPose
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass endEffectorPose-request (<endEffectorPose-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <endEffectorPose-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'endEffectorPose-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ur10_robot_arm-srv:<endEffectorPose-request> is deprecated: use ur10_robot_arm-srv:endEffectorPose-request instead.")))

(cl:ensure-generic-function 'checkPose-val :lambda-list '(m))
(cl:defmethod checkPose-val ((m <endEffectorPose-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ur10_robot_arm-srv:checkPose-val is deprecated.  Use ur10_robot_arm-srv:checkPose instead.")
  (checkPose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <endEffectorPose-request>) ostream)
  "Serializes a message object of type '<endEffectorPose-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'checkPose) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <endEffectorPose-request>) istream)
  "Deserializes a message object of type '<endEffectorPose-request>"
    (cl:setf (cl:slot-value msg 'checkPose) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<endEffectorPose-request>)))
  "Returns string type for a service object of type '<endEffectorPose-request>"
  "ur10_robot_arm/endEffectorPoseRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'endEffectorPose-request)))
  "Returns string type for a service object of type 'endEffectorPose-request"
  "ur10_robot_arm/endEffectorPoseRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<endEffectorPose-request>)))
  "Returns md5sum for a message object of type '<endEffectorPose-request>"
  "ab49f52154a9a8f037faf1e645e24d47")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'endEffectorPose-request)))
  "Returns md5sum for a message object of type 'endEffectorPose-request"
  "ab49f52154a9a8f037faf1e645e24d47")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<endEffectorPose-request>)))
  "Returns full string definition for message of type '<endEffectorPose-request>"
  (cl:format cl:nil "bool checkPose~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'endEffectorPose-request)))
  "Returns full string definition for message of type 'endEffectorPose-request"
  (cl:format cl:nil "bool checkPose~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <endEffectorPose-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <endEffectorPose-request>))
  "Converts a ROS message object to a list"
  (cl:list 'endEffectorPose-request
    (cl:cons ':checkPose (checkPose msg))
))
;//! \htmlinclude endEffectorPose-response.msg.html

(cl:defclass <endEffectorPose-response> (roslisp-msg-protocol:ros-message)
  ((position_x
    :reader position_x
    :initarg :position_x
    :type cl:float
    :initform 0.0)
   (position_y
    :reader position_y
    :initarg :position_y
    :type cl:float
    :initform 0.0)
   (position_z
    :reader position_z
    :initarg :position_z
    :type cl:float
    :initform 0.0)
   (orientation_x
    :reader orientation_x
    :initarg :orientation_x
    :type cl:float
    :initform 0.0)
   (orientation_y
    :reader orientation_y
    :initarg :orientation_y
    :type cl:float
    :initform 0.0)
   (orientation_z
    :reader orientation_z
    :initarg :orientation_z
    :type cl:float
    :initform 0.0)
   (orientation_w
    :reader orientation_w
    :initarg :orientation_w
    :type cl:float
    :initform 0.0))
)

(cl:defclass endEffectorPose-response (<endEffectorPose-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <endEffectorPose-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'endEffectorPose-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ur10_robot_arm-srv:<endEffectorPose-response> is deprecated: use ur10_robot_arm-srv:endEffectorPose-response instead.")))

(cl:ensure-generic-function 'position_x-val :lambda-list '(m))
(cl:defmethod position_x-val ((m <endEffectorPose-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ur10_robot_arm-srv:position_x-val is deprecated.  Use ur10_robot_arm-srv:position_x instead.")
  (position_x m))

(cl:ensure-generic-function 'position_y-val :lambda-list '(m))
(cl:defmethod position_y-val ((m <endEffectorPose-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ur10_robot_arm-srv:position_y-val is deprecated.  Use ur10_robot_arm-srv:position_y instead.")
  (position_y m))

(cl:ensure-generic-function 'position_z-val :lambda-list '(m))
(cl:defmethod position_z-val ((m <endEffectorPose-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ur10_robot_arm-srv:position_z-val is deprecated.  Use ur10_robot_arm-srv:position_z instead.")
  (position_z m))

(cl:ensure-generic-function 'orientation_x-val :lambda-list '(m))
(cl:defmethod orientation_x-val ((m <endEffectorPose-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ur10_robot_arm-srv:orientation_x-val is deprecated.  Use ur10_robot_arm-srv:orientation_x instead.")
  (orientation_x m))

(cl:ensure-generic-function 'orientation_y-val :lambda-list '(m))
(cl:defmethod orientation_y-val ((m <endEffectorPose-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ur10_robot_arm-srv:orientation_y-val is deprecated.  Use ur10_robot_arm-srv:orientation_y instead.")
  (orientation_y m))

(cl:ensure-generic-function 'orientation_z-val :lambda-list '(m))
(cl:defmethod orientation_z-val ((m <endEffectorPose-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ur10_robot_arm-srv:orientation_z-val is deprecated.  Use ur10_robot_arm-srv:orientation_z instead.")
  (orientation_z m))

(cl:ensure-generic-function 'orientation_w-val :lambda-list '(m))
(cl:defmethod orientation_w-val ((m <endEffectorPose-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ur10_robot_arm-srv:orientation_w-val is deprecated.  Use ur10_robot_arm-srv:orientation_w instead.")
  (orientation_w m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <endEffectorPose-response>) ostream)
  "Serializes a message object of type '<endEffectorPose-response>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'position_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'position_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'position_z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'orientation_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'orientation_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'orientation_z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'orientation_w))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <endEffectorPose-response>) istream)
  "Deserializes a message object of type '<endEffectorPose-response>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'position_x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'position_y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'position_z) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'orientation_x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'orientation_y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'orientation_z) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'orientation_w) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<endEffectorPose-response>)))
  "Returns string type for a service object of type '<endEffectorPose-response>"
  "ur10_robot_arm/endEffectorPoseResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'endEffectorPose-response)))
  "Returns string type for a service object of type 'endEffectorPose-response"
  "ur10_robot_arm/endEffectorPoseResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<endEffectorPose-response>)))
  "Returns md5sum for a message object of type '<endEffectorPose-response>"
  "ab49f52154a9a8f037faf1e645e24d47")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'endEffectorPose-response)))
  "Returns md5sum for a message object of type 'endEffectorPose-response"
  "ab49f52154a9a8f037faf1e645e24d47")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<endEffectorPose-response>)))
  "Returns full string definition for message of type '<endEffectorPose-response>"
  (cl:format cl:nil "float32 position_x~%float32 position_y~%float32 position_z~%float32 orientation_x~%float32 orientation_y~%float32 orientation_z~%float32 orientation_w~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'endEffectorPose-response)))
  "Returns full string definition for message of type 'endEffectorPose-response"
  (cl:format cl:nil "float32 position_x~%float32 position_y~%float32 position_z~%float32 orientation_x~%float32 orientation_y~%float32 orientation_z~%float32 orientation_w~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <endEffectorPose-response>))
  (cl:+ 0
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <endEffectorPose-response>))
  "Converts a ROS message object to a list"
  (cl:list 'endEffectorPose-response
    (cl:cons ':position_x (position_x msg))
    (cl:cons ':position_y (position_y msg))
    (cl:cons ':position_z (position_z msg))
    (cl:cons ':orientation_x (orientation_x msg))
    (cl:cons ':orientation_y (orientation_y msg))
    (cl:cons ':orientation_z (orientation_z msg))
    (cl:cons ':orientation_w (orientation_w msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'endEffectorPose)))
  'endEffectorPose-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'endEffectorPose)))
  'endEffectorPose-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'endEffectorPose)))
  "Returns string type for a service object of type '<endEffectorPose>"
  "ur10_robot_arm/endEffectorPose")