extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func updateHands(time):
	# print_debug(">>>time: ", time, ", ", (float(360*(time - int(time))))-90, ", ", int(30*time)-90)
	$minuteHand.rotation_degrees = (float(360*(time - int(time))))-90
	$hourHand.rotation_degrees = int(30*time)-90
