#!/usr/bin/env python
import rospy
from ur10_robot_arm.srv import chatPrompt, chatPromptResponse, chatPromptRequest
import json
import urllib2 

class chatGPT(object):
    def __init__(self):
        self.server = rospy.Service('/chat_gpt_service', chatPrompt, self.chat_callback)
        self.api_url = "https://api.openai.com/v1/chat/completions"
        self.api_key = "apiKey"
        rospy.loginfo("Ready...")

    def chat_callback(self, req):
        rospy.loginfo("Received prompt: %s", req.prompt)
        if req.prompt:
            res = chatPromptResponse()
            
            detailed_prompt = self.generate_detailed_prompt(req.prompt)
            res.response = self.chat_gpt_response(detailed_prompt)
            return res
        else:
            res = chatPromptResponse()
            res.response = "Error: Empty prompt"
            return res

    def extract_colors_from_prompt(self, user_prompt):
        """Extract color names from user input using simple keyword matching"""
        color_keywords = ['red', 'green', 'blue', 'yellow', 'orange', 'purple', 'black', 'white', 'gray', 'darkgrey']
        
        user_prompt_lower = user_prompt.lower()
        found_colors = []
        
        for color in color_keywords:
            if color in user_prompt_lower:
                found_colors.append(color)
        
        return found_colors

    def generate_detailed_prompt(self, user_prompt):
        """Generate a detailed prompt with color-specific instructions"""
        colors = self.extract_colors_from_prompt(user_prompt)
        
        if not colors:
            return user_prompt 
        
        color_list = " and ".join(colors)
        
        
        detailed_prompt = (
            "A user wants to spawn colored boxes in Gazebo using Gazebo material colors: " + color_list + "\n\n" +
            "The colors are specified as Gazebo materials in the SDF:\n" +
            "<uri>file://media/materials/scripts/gazebo.material</uri>\n" +
            "<name>Gazebo/COLOR</name>\n\n" +
            "Generate optimal HSV color ranges for OpenCV detection that work with Gazebo's standard material colors under typical simulation lighting.\n\n" +
            "For each Gazebo material color in " + color_list + ", provide:\n" +
            "- One HSV range for reliable detection\n" +
            "- OpenCV HSV format: H: 0-180, S: 0-255, V: 0-255\n" +
            "- Format: min_color = np.array([H, S, V]) and max_color = np.array([H, S, V])\n\n" +
            "Return only the HSV ranges in the exact code format needed."
        )
        
        rospy.loginfo("Generated detailed prompt for colors: %s", colors)
        return detailed_prompt

    def chat_gpt_response(self, prompt):
        try:
            
            data = {
                "model": "gpt-3.5-turbo",
                "messages": [{"role": "user", "content": prompt}],
                "max_tokens": 250  
            }
            
            
            json_data = json.dumps(data)
            
            
            headers = {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer {}'.format(self.api_key)
            }
            
            req = urllib2.Request(self.api_url, json_data, headers)
            response = urllib2.urlopen(req)
            response_data = json.loads(response.read())
            
            
            answer = response_data['choices'][0]['message']['content']
            rospy.loginfo("ChatGPT response: %s", answer)
            return answer.strip()
            
        except Exception as e:
            error_msg = "Error calling OpenAI API: {}".format(str(e))
            rospy.logerr(error_msg)
            return error_msg

if __name__ == '__main__':
    rospy.init_node('chat_gpt_service', anonymous=True)
    rospy.loginfo("ChatGPT node initialized, waiting for requests...")
    chat_gpt = chatGPT() 
    rospy.spin()