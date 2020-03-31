#!/usr/bin/env python

from __future__ import print_function

import roslib; roslib.load_manifest('marsians_teleop')
import rospy

from geometry_msgs.msg import Twist

import sys, select, termios, tty

helpMsg = """
Reading from the keyboard  and Publishing to Twist!
---------------------------
For Ackerman movement:
        i
   j    k    l

For Crab movement, hold down the shift key:
---------------------------
   r    t    y
   f    g    h
   v    b    n

anything else : stop

CTRL-C to quit
"""

moveBindings = {

# For Ackerman movement
        'i' : (1,0,0,0),
        'j' : (0,0,0,-1),
        'k' : (-1,0,0,0),
        'l' : (0,0,0,1),

# For Crab movement
        't' : (1,0,0,0),
        'f' : (0,1,0,0),
        'h' : (0,-1,0,0),
        'r' : (1,1,0,0),
        'b' : (-1,0,0,0),
        'n' : (-1,-1,0,0),
        'v' : (-1,1,0,0),
        'y' : (1,-1,0,0),
    }

def getKey():
    tty.setraw(sys.stdin.fileno())
    select.select([sys.stdin], [], [], 0)
    key = sys.stdin.read(1)
    termios.tcsetattr(sys.stdin, termios.TCSADRAIN, settings)
    return key


if __name__=="__main__":
    settings = termios.tcgetattr(sys.stdin)

    pub = rospy.Publisher('/scout_1/skid_cmd_vel', Twist, queue_size = 1)
    rospy.init_node('marsians_teleop_keyboard')

    maxVel = 8.5 # m/s
    minVel = -8.5 # m/s
    maxTheta = 5.57 # rads/s
    minTheta = -5.57 # rads/s

    x = 0
    y = 0
    z = 0
    th = 0
    linRes = 0.1
    thetaRes = 0.15

    try:
        print(helpMsg)
        while(1):
            key = getKey()
            if key in moveBindings.keys():
                x = x + moveBindings[key][0] * linRes;
                if x > maxVel:
                    x = maxVel
                elif x < minVel:
                    x = minVel
                y = y + moveBindings[key][1] * linRes;
                z = z + moveBindings[key][2] * linRes;
                th = th + moveBindings[key][3] * thetaRes;
                if th > maxTheta:
                    th = maxTheta
                elif th < minTheta:
                    th = minTheta

            else:
                x = 0
                y = 0
                z = 0
                th = 0
                if (key == '\x03'):
                    break

            twist = Twist()
            twist.linear.x = x; twist.linear.y = y; twist.linear.z = z;
            twist.angular.x = 0; twist.angular.y = 0; twist.angular.z = th
            pub.publish(twist)

    except Exception as e:
        print(e)

    finally:
        twist = Twist()
        twist.linear.x = 0; twist.linear.y = 0; twist.linear.z = 0
        twist.angular.x = 0; twist.angular.y = 0; twist.angular.z = 0
        pub.publish(twist)

        termios.tcsetattr(sys.stdin, termios.TCSADRAIN, settings)
