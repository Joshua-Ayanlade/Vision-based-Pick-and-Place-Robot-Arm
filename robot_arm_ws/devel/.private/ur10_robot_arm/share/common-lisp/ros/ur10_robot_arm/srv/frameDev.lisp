; Auto-generated. Do not edit!


(cl:in-package ur10_robot_arm-srv)


;//! \htmlinclude frameDev-request.msg.html

(cl:defclass <frameDev-request> (roslisp-msg-protocol:ros-message)
  ((color
    :reader color
    :initarg :color
    :type cl:string
    :initform ""))
)

(cl:defclass frameDev-request (<frameDev-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <frameDev-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'frameDev-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ur10_robot_arm-srv:<frameDev-request> is deprecated: use ur10_robot_arm-srv:frameDev-request instead.")))

(cl:ensure-generic-function 'color-val :lambda-list '(m))
(cl:defmethod color-val ((m <frameDev-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ur10_robot_arm-srv:color-val is deprecated.  Use ur10_robot_arm-srv:color instead.")
  (color m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <frameDev-request>) ostream)
  "Serializes a message object of type '<frameDev-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'color))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'color))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <frameDev-request>) istream)
  "Deserializes a message object of type '<frameDev-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'color) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'color) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<frameDev-request>)))
  "Returns string type for a service object of type '<frameDev-request>"
  "ur10_robot_arm/frameDevRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'frameDev-request)))
  "Returns string type for a service object of type 'frameDev-request"
  "ur10_robot_arm/frameDevRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<frameDev-request>)))
  "Returns md5sum for a message object of type '<frameDev-request>"
  "a3a39a6de41cd121631db316fe36d1b6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'frameDev-request)))
  "Returns md5sum for a message object of type 'frameDev-request"
  "a3a39a6de41cd121631db316fe36d1b6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<frameDev-request>)))
  "Returns full string definition for message of type '<frameDev-request>"
  (cl:format cl:nil "string color~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'frameDev-request)))
  "Returns full string definition for message of type 'frameDev-request"
  (cl:format cl:nil "string color~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <frameDev-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'color))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <frameDev-request>))
  "Converts a ROS message object to a list"
  (cl:list 'frameDev-request
    (cl:cons ':color (color msg))
))
;//! \htmlinclude frameDev-response.msg.html

(cl:defclass <frameDev-response> (roslisp-msg-protocol:ros-message)
  ((x_dev
    :reader x_dev
    :initarg :x_dev
    :type cl:integer
    :initform 0)
   (y_dev
    :reader y_dev
    :initarg :y_dev
    :type cl:integer
    :initform 0))
)

(cl:defclass frameDev-response (<frameDev-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <frameDev-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'frameDev-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ur10_robot_arm-srv:<frameDev-response> is deprecated: use ur10_robot_arm-srv:frameDev-response instead.")))

(cl:ensure-generic-function 'x_dev-val :lambda-list '(m))
(cl:defmethod x_dev-val ((m <frameDev-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ur10_robot_arm-srv:x_dev-val is deprecated.  Use ur10_robot_arm-srv:x_dev instead.")
  (x_dev m))

(cl:ensure-generic-function 'y_dev-val :lambda-list '(m))
(cl:defmethod y_dev-val ((m <frameDev-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ur10_robot_arm-srv:y_dev-val is deprecated.  Use ur10_robot_arm-srv:y_dev instead.")
  (y_dev m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <frameDev-response>) ostream)
  "Serializes a message object of type '<frameDev-response>"
  (cl:let* ((signed (cl:slot-value msg 'x_dev)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'y_dev)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <frameDev-response>) istream)
  "Deserializes a message object of type '<frameDev-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'x_dev) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'y_dev) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<frameDev-response>)))
  "Returns string type for a service object of type '<frameDev-response>"
  "ur10_robot_arm/frameDevResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'frameDev-response)))
  "Returns string type for a service object of type 'frameDev-response"
  "ur10_robot_arm/frameDevResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<frameDev-response>)))
  "Returns md5sum for a message object of type '<frameDev-response>"
  "a3a39a6de41cd121631db316fe36d1b6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'frameDev-response)))
  "Returns md5sum for a message object of type 'frameDev-response"
  "a3a39a6de41cd121631db316fe36d1b6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<frameDev-response>)))
  "Returns full string definition for message of type '<frameDev-response>"
  (cl:format cl:nil "~%int32 x_dev~%int32 y_dev~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'frameDev-response)))
  "Returns full string definition for message of type 'frameDev-response"
  (cl:format cl:nil "~%int32 x_dev~%int32 y_dev~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <frameDev-response>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <frameDev-response>))
  "Converts a ROS message object to a list"
  (cl:list 'frameDev-response
    (cl:cons ':x_dev (x_dev msg))
    (cl:cons ':y_dev (y_dev msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'frameDev)))
  'frameDev-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'frameDev)))
  'frameDev-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'frameDev)))
  "Returns string type for a service object of type '<frameDev>"
  "ur10_robot_arm/frameDev")