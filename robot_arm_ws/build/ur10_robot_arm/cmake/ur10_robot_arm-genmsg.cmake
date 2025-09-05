# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "ur10_robot_arm: 0 messages, 2 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(ur10_robot_arm_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/frameDev.srv" NAME_WE)
add_custom_target(_ur10_robot_arm_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "ur10_robot_arm" "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/frameDev.srv" ""
)

get_filename_component(_filename "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/endEffectorPose.srv" NAME_WE)
add_custom_target(_ur10_robot_arm_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "ur10_robot_arm" "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/endEffectorPose.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(ur10_robot_arm
  "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/frameDev.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ur10_robot_arm
)
_generate_srv_cpp(ur10_robot_arm
  "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/endEffectorPose.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ur10_robot_arm
)

### Generating Module File
_generate_module_cpp(ur10_robot_arm
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ur10_robot_arm
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(ur10_robot_arm_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(ur10_robot_arm_generate_messages ur10_robot_arm_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/frameDev.srv" NAME_WE)
add_dependencies(ur10_robot_arm_generate_messages_cpp _ur10_robot_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/endEffectorPose.srv" NAME_WE)
add_dependencies(ur10_robot_arm_generate_messages_cpp _ur10_robot_arm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ur10_robot_arm_gencpp)
add_dependencies(ur10_robot_arm_gencpp ur10_robot_arm_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ur10_robot_arm_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(ur10_robot_arm
  "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/frameDev.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ur10_robot_arm
)
_generate_srv_eus(ur10_robot_arm
  "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/endEffectorPose.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ur10_robot_arm
)

### Generating Module File
_generate_module_eus(ur10_robot_arm
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ur10_robot_arm
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(ur10_robot_arm_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(ur10_robot_arm_generate_messages ur10_robot_arm_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/frameDev.srv" NAME_WE)
add_dependencies(ur10_robot_arm_generate_messages_eus _ur10_robot_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/endEffectorPose.srv" NAME_WE)
add_dependencies(ur10_robot_arm_generate_messages_eus _ur10_robot_arm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ur10_robot_arm_geneus)
add_dependencies(ur10_robot_arm_geneus ur10_robot_arm_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ur10_robot_arm_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(ur10_robot_arm
  "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/frameDev.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ur10_robot_arm
)
_generate_srv_lisp(ur10_robot_arm
  "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/endEffectorPose.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ur10_robot_arm
)

### Generating Module File
_generate_module_lisp(ur10_robot_arm
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ur10_robot_arm
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(ur10_robot_arm_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(ur10_robot_arm_generate_messages ur10_robot_arm_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/frameDev.srv" NAME_WE)
add_dependencies(ur10_robot_arm_generate_messages_lisp _ur10_robot_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/endEffectorPose.srv" NAME_WE)
add_dependencies(ur10_robot_arm_generate_messages_lisp _ur10_robot_arm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ur10_robot_arm_genlisp)
add_dependencies(ur10_robot_arm_genlisp ur10_robot_arm_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ur10_robot_arm_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(ur10_robot_arm
  "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/frameDev.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ur10_robot_arm
)
_generate_srv_nodejs(ur10_robot_arm
  "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/endEffectorPose.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ur10_robot_arm
)

### Generating Module File
_generate_module_nodejs(ur10_robot_arm
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ur10_robot_arm
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(ur10_robot_arm_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(ur10_robot_arm_generate_messages ur10_robot_arm_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/frameDev.srv" NAME_WE)
add_dependencies(ur10_robot_arm_generate_messages_nodejs _ur10_robot_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/endEffectorPose.srv" NAME_WE)
add_dependencies(ur10_robot_arm_generate_messages_nodejs _ur10_robot_arm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ur10_robot_arm_gennodejs)
add_dependencies(ur10_robot_arm_gennodejs ur10_robot_arm_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ur10_robot_arm_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(ur10_robot_arm
  "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/frameDev.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ur10_robot_arm
)
_generate_srv_py(ur10_robot_arm
  "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/endEffectorPose.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ur10_robot_arm
)

### Generating Module File
_generate_module_py(ur10_robot_arm
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ur10_robot_arm
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(ur10_robot_arm_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(ur10_robot_arm_generate_messages ur10_robot_arm_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/frameDev.srv" NAME_WE)
add_dependencies(ur10_robot_arm_generate_messages_py _ur10_robot_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/vboxuser/robot_arm_ws/src/ur10_robot_arm/srv/endEffectorPose.srv" NAME_WE)
add_dependencies(ur10_robot_arm_generate_messages_py _ur10_robot_arm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ur10_robot_arm_genpy)
add_dependencies(ur10_robot_arm_genpy ur10_robot_arm_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ur10_robot_arm_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ur10_robot_arm)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ur10_robot_arm
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(ur10_robot_arm_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ur10_robot_arm)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ur10_robot_arm
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(ur10_robot_arm_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ur10_robot_arm)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ur10_robot_arm
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(ur10_robot_arm_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ur10_robot_arm)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ur10_robot_arm
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(ur10_robot_arm_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ur10_robot_arm)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ur10_robot_arm\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ur10_robot_arm
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(ur10_robot_arm_generate_messages_py std_msgs_generate_messages_py)
endif()
