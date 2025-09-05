#!/usr/bin/env python
import os

with open("model.sdf","w") as f:
        f.write("""<?xml version='1.0'?>
<sdf version ='1.4'>
                """)
#generate model for each tag   
for i in range(1,5):
    with open("model.sdf","a") as f:
        f.write("""
  <model name="ar_tag_%d">
      <static>true</static>
      <!--pose>0 0 0.63 0 0 0</pose-->
      <link name="link">
        <visual name="visual">
          <geometry><box><size>0.2 0.01 0.2</size></box></geometry>
          <material>
            <script>
              <uri>model://ar_tag/materials</uri>
	            <uri>model://ar_tag/textures</uri>
              <name>ar_tag/tag_%d</name>
            </script>
          </material>
        </visual>
	
	<collision name="collision">
        <geometry>
          <box>
            <size>0.2 0.01 0.2</size>
          </box>
        </geometry>
      </collision>

      </link>
  </model>
"""%(i,i))
        
with open("model.sdf","a") as f:
        f.write("""
</sdf>
                """)
        
#To generate the config file
with open("model.config","w") as f:
        f.write("""<?xml version="1.0"?>
<model>
  <name>AR_Tag</name>
  <sdf version="1.4">model.sdf</sdf>
</model>
                """)