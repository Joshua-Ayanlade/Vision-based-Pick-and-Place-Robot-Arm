// Auto-generated. Do not edit!

// (in-package ur10_robot_arm.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class frameDevRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.color = null;
    }
    else {
      if (initObj.hasOwnProperty('color')) {
        this.color = initObj.color
      }
      else {
        this.color = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type frameDevRequest
    // Serialize message field [color]
    bufferOffset = _serializer.string(obj.color, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type frameDevRequest
    let len;
    let data = new frameDevRequest(null);
    // Deserialize message field [color]
    data.color = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.color.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'ur10_robot_arm/frameDevRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '89e44dcab627a2c43a70ae1100695caa';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string color
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new frameDevRequest(null);
    if (msg.color !== undefined) {
      resolved.color = msg.color;
    }
    else {
      resolved.color = ''
    }

    return resolved;
    }
};

class frameDevResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.x_dev = null;
      this.y_dev = null;
    }
    else {
      if (initObj.hasOwnProperty('x_dev')) {
        this.x_dev = initObj.x_dev
      }
      else {
        this.x_dev = 0;
      }
      if (initObj.hasOwnProperty('y_dev')) {
        this.y_dev = initObj.y_dev
      }
      else {
        this.y_dev = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type frameDevResponse
    // Serialize message field [x_dev]
    bufferOffset = _serializer.int32(obj.x_dev, buffer, bufferOffset);
    // Serialize message field [y_dev]
    bufferOffset = _serializer.int32(obj.y_dev, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type frameDevResponse
    let len;
    let data = new frameDevResponse(null);
    // Deserialize message field [x_dev]
    data.x_dev = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [y_dev]
    data.y_dev = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'ur10_robot_arm/frameDevResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e29eb4405f127a71471e9c031c76a1e5';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    int32 x_dev
    int32 y_dev
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new frameDevResponse(null);
    if (msg.x_dev !== undefined) {
      resolved.x_dev = msg.x_dev;
    }
    else {
      resolved.x_dev = 0
    }

    if (msg.y_dev !== undefined) {
      resolved.y_dev = msg.y_dev;
    }
    else {
      resolved.y_dev = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: frameDevRequest,
  Response: frameDevResponse,
  md5sum() { return 'a3a39a6de41cd121631db316fe36d1b6'; },
  datatype() { return 'ur10_robot_arm/frameDev'; }
};
