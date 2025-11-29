#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
import sys
from ur10_robot_arm.srv import chatPrompt

def extract_colors_from_input(user_prompt):
    """Extract color names from user input using simple keyword matching"""
    color_keywords = ['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'black', 'white', 'gray', 'darkgrey']
    
    user_prompt_lower = user_prompt.lower()
    found_colors = []
    
    for color in color_keywords:
        if color in user_prompt_lower:
            found_colors.append(color)
    
    return found_colors

def get_hsv_ranges_from_chatgpt_service(colors, user_input):
    try:
        rospy.wait_for_service('/chat_gpt_service', timeout=10)
        chat_service = rospy.ServiceProxy('/chat_gpt_service', chatPrompt)
        
        # Create the prompt that will be processed by the ChatGPT node
        color_list = " and ".join(colors)
        prompt = "spawn {} boxes in Gazebo simulation".format(color_list)
        
        rospy.loginfo("Sending request to ChatGPT service for colors: %s", colors)
        response = chat_service(prompt=prompt)
        
        # Parse the response to extract HSV values
        hsv_ranges = parse_chatgpt_response(response.response, colors)
        return hsv_ranges
        
    except rospy.ROSException:
        rospy.logerr("ChatGPT service not available. Make sure chat_gpt_service node is running.")
        return None
    except Exception as e:
        rospy.logerr("Error calling ChatGPT service: %s", str(e))
        return None

def parse_chatgpt_response(response, expected_colors):
    """Parse ChatGPT response to extract HSV ranges"""
    hsv_ranges = {}
    
    lines = response.split('\n')
    rospy.loginfo("Parsing ChatGPT response for %d colors", len(expected_colors))
    
    for color in expected_colors:
        min_hsv = None
        max_hsv = None
        
        for line in lines:
            line = line.strip()
            
            if "min_{}".format(color).lower() in line.lower() and "np.array" in line:
                try:
                    start_idx = line.find('[')
                    end_idx = line.find(']')
                    if start_idx != -1 and end_idx != -1:
                        array_content = line[start_idx + 1:end_idx]
                        values = [int(x.strip()) for x in array_content.split(',')]
                        if len(values) == 3:
                            min_hsv = values
                            rospy.loginfo("Found min_%s: %s", color, min_hsv)
                except Exception as e:
                    rospy.logwarn("Error parsing min_%s: %s", color, str(e))
            
            elif "max_{}".format(color).lower() in line.lower() and "np.array" in line:
                try:
                    start_idx = line.find('[')
                    end_idx = line.find(']')
                    if start_idx != -1 and end_idx != -1:
                        array_content = line[start_idx + 1:end_idx]
                        values = [int(x.strip()) for x in array_content.split(',')]
                        if len(values) == 3:
                            max_hsv = values
                            rospy.loginfo("Found max_%s: %s", color, max_hsv)
                except Exception as e:
                    rospy.logwarn("Error parsing max_%s: %s", color, str(e))
        
        
        if min_hsv and not max_hsv:
            for line in lines:
                if "min_{}".format(color).lower() in line.lower() and "max_{}".format(color).lower() in line.lower():
                    try:
                        # Extract both arrays from the same line
                        arrays = line.split('np.array')
                        if len(arrays) >= 3:  # Should have min and max
                            # Parse min array (arrays[1])
                            min_start = arrays[1].find('[')
                            min_end = arrays[1].find(']')
                            if min_start != -1 and min_end != -1:
                                min_content = arrays[1][min_start + 1:min_end]
                                min_hsv = [int(x.strip()) for x in min_content.split(',')]
                            
                            # Parse max array (arrays[2])
                            max_start = arrays[2].find('[')
                            max_end = arrays[2].find(']')
                            if max_start != -1 and max_end != -1:
                                max_content = arrays[2][max_start + 1:max_end]
                                max_hsv = [int(x.strip()) for x in max_content.split(',')]
                                rospy.loginfo("Found max_%s on same line: %s", color, max_hsv)
                    except Exception as e:
                        rospy.logwarn("Error parsing combined min/max line for %s: %s", color, str(e))
        

        if min_hsv and max_hsv:
            hsv_ranges[color] = {'min': min_hsv, 'max': max_hsv}
            rospy.loginfo("Successfully parsed HSV ranges for %s", color)
        else:
            rospy.logerr("Failed to parse complete HSV ranges for %s", color)
            rospy.logerr("Min found: %s, Max found: %s", min_hsv is not None, max_hsv is not None)
    
    return hsv_ranges

def setup_ros_parameters(colors, hsv_ranges):
    """Set up all required ROS parameters"""
    if not hsv_ranges:
        rospy.logerr("No HSV ranges available! Cannot set parameters.")
        return False
        
    missing_colors = [color for color in colors if color not in hsv_ranges]
    if missing_colors:
        rospy.logerr("Missing HSV ranges for colors: %s", missing_colors)
        return False
    
    # To set available colors for object detection
    rospy.set_param('/colors', colors)
    rospy.loginfo("Set /colors parameter: %s", colors)
    
    # To set HSV ranges for each color
    for color, ranges in hsv_ranges.items():
        rospy.set_param('/hsv_ranges/' + color + '/min', ranges['min'])
        rospy.set_param('/hsv_ranges/' + color + '/max', ranges['max'])
        rospy.loginfo("Set HSV for %s: min=%s, max=%s", color, ranges['min'], ranges['max'])
    
    # To set spawn colors for Gazebo
    rospy.set_param('/spawn_colors', colors)
    rospy.loginfo("Set /spawn_colors parameter: %s", colors)
    
    return True

def main():
    rospy.init_node('color_setup_node')
    
    if len(sys.argv) > 1:
        user_input = ' '.join(sys.argv[1:])
        rospy.loginfo("User input: %s", user_input)
        
        # To extract colors from user input
        colors = extract_colors_from_input(user_input)
        
        if not colors:
            rospy.logerr("No colors found in input: %s", user_input)
            return
        
        rospy.loginfo("Extracted colors: %s", colors)
        
        # To get HSV ranges from ChatGPT service
        hsv_ranges = get_hsv_ranges_from_chatgpt_service(colors, user_input)
        
        if hsv_ranges and setup_ros_parameters(colors, hsv_ranges):
            rospy.loginfo("Success! All parameters set for colors: %s", colors)
            rospy.loginfo("  /colors: %s", colors)
            rospy.loginfo("  /spawn_colors: %s", colors)
            for color in colors:
                rospy.loginfo("  /hsv_ranges/%s/min: %s", color, hsv_ranges[color]['min'])
                rospy.loginfo("  /hsv_ranges/%s/max: %s", color, hsv_ranges[color]['max'])
            

            rospy.loginfo("Keeping node alive to maintain parameters...")
            rospy.spin()
        else:
            rospy.logerr("FAILED to set up parameters")
            
    else:
        rospy.logerr("Usage: rosrun ur10_robot_arm setup_colors.py 'spawn red and blue boxes'")
        rospy.logerr("Example: rosrun ur10_robot_arm setup_colors.py 'I want green and yellow blocks'")

if __name__ == '__main__':
    main()