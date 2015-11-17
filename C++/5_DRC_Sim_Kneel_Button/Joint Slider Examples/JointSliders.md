# Joint Slider Widget
### UI
![Joint Slider UI](../images/JointSliders.jpg "Joint Sliders UI")

### Description

The purpose of this widget is to control each individual joint on the robot.

### Features

Send - Joints on robot will not move to "set" position until send button is pressed 

Discard - Will discard changes to slider, and reset sliders to represent current position of joints

Sub Gui - 
	Slider - Displays current position of every limb. Move a slider to change that position 


### Classes

Control Class – JointSliders

GUI Class – JointSlidersGUI

sub GUI Class - SingleJointSliderGUI 

### Files

[joint_sliders.cpp](../../src/widgets/joint_sliders.cpp)  
[joint_sliders.hpp](../../include/drc_gui/widgets/joint_sliders.hpp)  
[joint_sliders.ui](../../ui/widgets/joint_sliders.ui)  


### [Return to DRC GUI](../../)
