# Vision-based Pick-and-Place-Robot-Arm
## Overview
<p align="justify">
This project implements a vision-based pick-and-place robot arm using ROS. Three cameras are used, each serving a specific purpose: AR-tag detection, object pose estimation, and environment mapping for collision avoidance. The robot arm leverages MoveIt for trajectory planning and includes custom ROS service servers for image processing and object position computation with respect to the camera frame center. Modifications were made to the "onAttach" trigger conditions in the GazeboGraspFix.cpp file (created by <a href="https://github.com/JenniferBuehler/gazebo-pkgs">Jennifer Buehler</a>) to improve the chances of successful grasping. Using prompt from the user via the command terminal, the color of the boxes to be spawned to Gazebo are extracted and their corresponding optminzed HSV ranges were automatically generated using a ChatGPT request which enables flexible color-based object detection without manually tuning HSV values.
</p>

## 📌 Key features:
- ✅ Vision-based control of a Universal Robots UR10 robotic arm for pick-and-place tasks.
- ✅ Gazebo simulation with scene cameras for AR-tag detection and MoveIt collision mapping (OctoMap).
- ✅ Custom Gazebo world file including the robot arm base stand, AR tags, and two scene cameras.
- ✅ Custom service server for tracking the current pose of the end effector, enabling seamless implementation of Cartesian trajectory motions.
- ✅ Custom service server for object center detection.
- ✅ Coordinate transformation of the camera frame for proper orientation of point cloud data in RViz.
- ✅ Custom **XACRO model** attaching an EGH gripper and mounting a camera to the gripper base frame for improved object tracking.
- ✅ Enhanced GazeboGraspFix for more reliable grasping.
- ✅ Custom chat gpt service for extracting color names from the user prompt and generating optimized HSV ranges for each color

---
## 📂 ur10_robot_arm Package structure
```bash
ur10_robot_arm/
├── config/  
│   └── joint_trajectory_controller.yaml   # Controller config for UR10 in Gazebo  
│
├── images/                                # Images for extracting HSV values of objects  
│
├── launch/  
│   ├── ar_marker_detect.launch            # Detect AR tags & compute poses wrt *ur_base_link*  
│   ├── target_pose_transform.launch       # Static transform of AR tag frames (linear & rotational)  
│   ├── ur10_w_gripper.launch              # Spawn UR10 + gripper, controllers, camera TF, RViz  
│   └── ur10_w_gripper_combo.launch        # Combo: all above + MoveIt, box spawner, camera & EE servers  
│
├── models/  
│   ├── ar_tag_generator.py                # Generate material files for AR markers  
│   └── sdf_config_generator.py            # Generate SDF config for AR markers  
│
├── scripts/  
│   ├── add_box.py                         # Spawn boxes in Gazebo  
│   ├── ar_tag.py                          # Main script for robot–AR tag interaction
│   ├── chat_gpt_server.py                 # Service: generate Max and Min HSV values of the requested color   
│   ├── endEffectorPose_server.py          # Service Server: get end-effector pose
│   ├── setup_color_hsv.py                 # Service Client: send user prompt to chatgpt server and place values in parameter server
│   └── stream_camera_server.py            # Service Server: detect object & compute camera deviation  
│
├── srv/  
│   ├── chatPrompt.srv                     # Service: request prompt model color → return color & HSV values 
│   ├── endEffectorPose.srv                # Service: request pose → return EE pose
│   └── frameDev.srv                       # Service: request color → return (x,y) deviation  
│
├── world/  
│   └── ar_marker_chand.world              # Gazebo world: UR10 base stand, AR tags, scene cameras  
│
├── xacro/  
│   ├── ur10_w_gripper.xacro               # UR10 + egh gripper, cameras, octomap  
│   └── multi_kinect.xacro                 # Define multiple Kinect camera models  
│
├── CMakeLists.txt  
└── package.xml

moveit/
├── config/    #trajectory controller configuration and sensors files 
├── launch/    #move_group and controllers launch files
├── CMakeLists.txt        
└── package.xml

ur_description/
├── meshes/    #mesh files for the gripper base and finger
├── urdf/    #xacro file for the gripper
├── CMakeLists.txt        
└── package.xml

egh_gripper_description/
├── meshes/    #mesh files for the gripper base and finger
├── urdf/    #xacro file for the gripper
├── CMakeLists.txt        
└── package.xml

grasps_fix_plugin/ #modified grasps fix plugin file for improved grasping

```

---
## Dependencies
- rospy
- std_msgs
- openCV
- message_generation
- gripper_action_controller
- moveit_package
- joint_state_publisher
- joint_state_publisher_gui
- robot_state_publisher
- rviz
- tf2_ros
- xacro

---
## 🛠️ Installation & Build
1.  Create a Catkin Workspace (if you haven't already):
    ```bash
    mkdir -p ~/catkin_ws/src
    cd ~/catkin_ws/
    catkin_make
    source devel/setup.bash
    ```
    
2. Clone the repository into your ROS workspace:  
   ```bash
    cd ~/catkin_ws/src
    git clone https://github.com/Joshua-Ayanlade/Vision-based-Pick-and-Place-Robot-Arm.git
    ```

3. Install Dependencies:
   ```bash
    cd ~/catkin_ws
    rosdep install --from-paths src --ignore-src -y
    ```

4. Build the Package:
   ```bash
    cd ~/catkin_ws
    catkin_make
    source devel/setup.bash
    ```

---
## ⚙️ Usage
   
1. Start the ROS Master:  
   `roscore`
   
2. Start the chat gpt server:  
   `rosrun ur10_robot_arm chat_gpt_server.py`

3. Start the setup color hsv service client with input request as argument:  
   `rosrun ur10_robot_arm setup_color_hsv.py 'spawn red and blue box in gazebo'`
   
4. Launch the Gazebo world, spawn the robot arm, load the box model, start the controllers, launch MoveIt, initialize pose transformation, start the AR-tag detector, and run the camera and end-effector pose servers:  
   `roslaunch ur10_robot_arm ur10_w_gripper_combo.launch`

5. Execute the pick-and-place routine and specify the AR tag from which you want to pick the object. Follow the prompts afterwards:
   
   `roslaunch ur10_robot_arm ar_tag.py 1`&nbsp;&nbsp;&nbsp;&nbsp;# *Robot arm moves towards AR Tag 1* 


---
## 🎥 Demo
![UR10+arm_Pick+'n'+Place (1)](https://github.com/user-attachments/assets/088f6231-3360-416a-a6d1-d8fd38d40a41)

---

## 🎥 Demo with ChatGPT api

![ur10arm](https://github.com/user-attachments/assets/206abb86-eaa5-4aa7-b879-3d9f1b1bbb46)

---

## 📚 Resources
- *A Systematic Approach to Learning Robot Programming with ROS* — Wyatt S. Newman  
- *Programming Robots with ROS* — Morgan Quigley et al.  
- *ROS by Example: Packages and Programs for Advanced Robot Behaviors (Vol. 2)* — R. Patrick Goebel  
- [ROS Wiki](https://wiki.ros.org)  
- [REP-103 Standard](https://www.ros.org/reps/rep-0103.html)  
- [Jennifer Buehler’s general-message-pkgs](https://github.com/JenniferBuehler/general-message-pkgs.git) 
- [Jennifer Buehler’s gazebo-pkgs](https://github.com/JenniferBuehler/gazebo-pkgs.git) 
- [Moveit](github.com/ros-planning/moveit)
  
## Acknowledgement
- ur_description package authored by **Wim Meeussen et al**
- egh_gripper_description package authored by **Jane Done**
