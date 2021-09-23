extends KinematicBody2D

export var speed = 200
export var movement_enabled = false

var player: Player = Player.new(0, "")

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	if movement_enabled:
		var velocity = Vector2(
			Input.get_joy_axis(player.id, JOY_AXIS_0) if abs(Input.get_joy_axis(player.id, JOY_AXIS_0)) > 0.1 else 0,
			Input.get_joy_axis(player.id, JOY_AXIS_1) if abs(Input.get_joy_axis(player.id, JOY_AXIS_1)) > 0.1 else 0
			).clamped(1)
		velocity = move_and_slide(velocity*speed)
