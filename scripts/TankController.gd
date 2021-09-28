extends KinematicBody2D

export var speed = 200
export var movement_enabled = false

var player: Player = Player.new(0, "")

onready var _body_sprite: AnimatedSprite = $BodySprite

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
		
		if velocity != Vector2.ZERO:
			_rotate_body_sprite(velocity)
			
		velocity = move_and_slide(velocity*speed)

func _rotate_body_sprite(velocity: Vector2):
	print(velocity)
	if abs(velocity.x) > abs(velocity.y):
		_body_sprite.frame = 0 if velocity.x > 0 else 1
	else:
		_body_sprite.frame = 3 if velocity.y > 0 else 2
