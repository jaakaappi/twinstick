extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
func _physics_process(delta):
	var velocity = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	velocity = move_and_slide(velocity)
