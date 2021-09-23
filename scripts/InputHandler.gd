extends Node
class_name InputHandler

func _ready():
	Input.connect("joy_connection_changed", self, "_joy_connection_changed")

func _process(delta):
	for id in Input.get_connected_joypads():
		if Input.is_joy_button_pressed(id, JOY_START):
			print(id, "star pressed")

func _joy_connection_changed(device, connected):
	print("Gamepad ", device, " connected" if connected else " disconnected")
