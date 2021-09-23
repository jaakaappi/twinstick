extends KinematicBody2D

export var speed = 200
export var movement_enabled = false

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	if movement_enabled:
		var velocity = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).clamped(1)
		velocity = move_and_slide(velocity*speed)
