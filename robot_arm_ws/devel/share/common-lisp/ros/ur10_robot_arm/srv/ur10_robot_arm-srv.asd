
(cl:in-package :asdf)

(defsystem "ur10_robot_arm-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "endEffectorPose" :depends-on ("_package_endEffectorPose"))
    (:file "_package_endEffectorPose" :depends-on ("_package"))
    (:file "frameDev" :depends-on ("_package_frameDev"))
    (:file "_package_frameDev" :depends-on ("_package"))
  ))