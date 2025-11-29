#! /usr/bin/env python

import rospy
from gazebo_msgs.srv import SpawnModel, SpawnModelRequest, SpawnModelResponse
from copy import deepcopy
from tf.transformations import quaternion_from_euler

cube_sdf_model = """<?xml version="1.0">
<sdf version = "1.4">
    <model name="MODELNAME">
        <static>0</static>
        <link name="link">
            <inertial>
                <mass>1.0</mass>
                <inertia>
                    <ixx>0.01</ixx>
                    <ixy>0.01</ixy>
                    <ixz>0.01</ixz>
                    <iyy>0.01</iyy>
                    <iyz>0.01</iyz>
                    <izz>0.01</izz>
                </inertia>
            </inertial>
            <collision name="box_collision0">
                <pose>0 0 0 0 0 0</pose>
                <geometry>
                    <box>
                        <size>SIZEXYZ</size>
                    </box>
                </geometry>
                <surface>
                    <bounce/>
                    <friction>
                        <ode>
                            <mu>100.0</mu>
                            <mu2>100.0</mu2>
                        </ode>
                    </friction>
                    <contact>
                        <ode>
                            <kp>10000000.0</kp>
                            <kd>1.0</kd>
                            <min_depth>0.0</min_depth>
                            <max_vel>0.0</max_vel>
                        </ode>
                    </contact>
                </surface>
            </collision>
            <visual name="box_visual0">
                <pose>0 0 0 0 0 0</pose>
                <geometry>
                    <box>
                        <size>SIZEXYZ</size>
                    </box>
                </geometry>
                <material>
                    <script>
                        <uri>file://media/materials/scripts/gazebo.material</uri>
                        <name>Gazebo/COLOR</name>
                    </script>
                </material>
            </visual>
            <velocity_decay>
                <linear>0.000000</linear>
                <angular>0.000000</angular>
            </velocity_decay>
            <self_collide>0</self_collide>
            <kinematic>0</kinematic>
            <gravity>1</gravity>
        </link>
    </model>
</sdf>
"""

def create_cube_request(sdf_model,modelname,color,px,py,pz,rr,rp,ry,sx,sy,sz):
    """Create a SpawnModelRequest with the parameters of the cube given.
    modelname: name of the model for gazebo
    px py pz: position of the cube (and it's collision cube)
    rr rp ry: rotation (roll, pitch, yaw) of the model
    sx sy sz: size of the cube"""
    cube = deepcopy(sdf_model)
    
    size_str = str(round(sx, 3)) + " " + \
        str(round(sy, 3)) + " " + str(round(sz, 3))
    cube = cube.replace('SIZEXYZ', size_str)
    
    cube = cube.replace('MODELNAME', str(modelname))
    cube = cube.replace('COLOR', str(color))

    req = SpawnModelRequest()
    req.model_name = modelname
    req.model_xml = cube
    req.initial_pose.position.x = px
    req.initial_pose.position.y = py
    req.initial_pose.position.z = pz

    q = quaternion_from_euler(rr, rp, ry)
    req.initial_pose.orientation.x = q[0]
    req.initial_pose.orientation.y = q[1]
    req.initial_pose.orientation.z = q[2]
    req.initial_pose.orientation.w = q[3]

    return req


if __name__ == '__main__':
    
    rospy.init_node('spawn_box_models')
    
    rospy.sleep(2.0)
    
    if rospy.has_param('/spawn_colors'):
        colors = rospy.get_param('/spawn_colors')
        rospy.loginfo("Using colors from parameter server: %s", colors)
    else:
        rospy.logerr("No colors found in parameter server! Please run ChatGPT node first.")
        rospy.logerr("Run: rosrun ur10_robot_arm setup_colors.py 'spawn red and blue boxes'")
        sys.exit(1)
    
    spawn_srv = rospy.ServiceProxy('/gazebo/spawn_sdf_model', SpawnModel)
    rospy.loginfo("Waiting for /gazebo/spawn_sdf_model service...")
    spawn_srv.wait_for_service()
    rospy.loginfo("Connected to service!")

    positions = [
        (-0.33, 0.88, 0.920), 
        (-0.165, 0.82, 0.920),
        (0.14, 0.82, 0.920),
        (0.14, 0.9, 0.920)
    ]

    for i, pos in enumerate(positions):
        color_index = i % len(colors)
        color_name = colors[color_index].capitalize() 
        
        rospy.loginfo("Spawning package$%d with color %s", i+1, color_name)
        
        request = create_cube_request(cube_sdf_model, 
                                    "package$" + str(i+1),
                                    color_name,
                                    pos[0], pos[1], pos[2],
                                    0.0, 0.0, 0.0,  # rotation
                                    0.06, 0.06, 0.1)  # size
        
        try:
            spawn_srv.call(request)
            rospy.loginfo("Successfully spawned package$%d", i+1)
        except Exception as e:
            rospy.logerr("Failed to spawn package$%d: %s", i+1, str(e))

    rospy.sleep(1.0)
    rospy.loginfo("Box spawning complete!")




