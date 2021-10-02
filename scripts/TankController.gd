extends KinematicBody2D

export var speed = 200
export var movement_enabled = false

var player: Player = Player.new(0, "")
export var _bullet_scene : PackedScene = preload("res://scenes/Bullet.tscn")

onready var _body_sprite: AnimatedSprite = $Body
onready var _turret_sprite: AnimatedSprite = $Turret
onready var _arrow_sprite: Sprite = $ArrowSprite

var _angle = Vector2.ZERO
var _next_shot = 0
var _fire_cooldown = 2000

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	if movement_enabled:
		var velocity = Vector2(
			Input.get_joy_axis(player.id, JOY_AXIS_0) if abs(Input.get_joy_axis(player.id, JOY_AXIS_0)) > 0.2 else 0,
			Input.get_joy_axis(player.id, JOY_AXIS_1) if abs(Input.get_joy_axis(player.id, JOY_AXIS_1)) > 0.2 else 0
			).clamped(1)
		
		_angle = Vector2(
			-Input.get_joy_axis(player.id, JOY_AXIS_3) if abs(Input.get_joy_axis(player.id, JOY_AXIS_3)) > 0.2 else 0,
			Input.get_joy_axis(player.id, JOY_AXIS_2) if abs(Input.get_joy_axis(player.id, JOY_AXIS_2)) > 0.2 else 0
			).clamped(1)
		
		if _angle.length() > 0:
			print(Vector2(_angle.y, _angle.x))
			_arrow_sprite.rotation = _angle.angle()
			_turret_sprite.rotation = _angle.angle()
		
		if velocity != Vector2.ZERO:
			_body_sprite.rotation = velocity.angle()
			
		velocity = move_and_slide(velocity*speed)
		
		if Input.is_joy_button_pressed(0, JOY_ANALOG_R2):
			if OS.get_ticks_msec() > _next_shot:
				_next_shot = OS.get_ticks_msec() + _fire_cooldown
				_shoot_bullet(_angle)
		
func _shoot_bullet(direction):
	var correct_direction = Vector2(direction.y, -direction.x)
	var bullet = _bullet_scene.instance()
	bullet.velocity = correct_direction * 500
	bullet.rotation = direction.angle()
	get_parent().add_child(bullet)
	bullet.position = global_position + correct_direction * 50
