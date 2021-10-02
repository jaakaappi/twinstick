extends KinematicBody2D

export var speed = 10000
export var movement_enabled = false
export var test_player_id = 0

var player: Player = Player.new(test_player_id, "")
export var _bullet_scene : PackedScene = preload("res://scenes/Bullet.tscn")

onready var _body_sprite: Sprite = $Body
onready var _turret_sprite: Sprite = $Turret
onready var _arrow_sprite: Sprite = $ArrowSprite

var _angle = Vector2.RIGHT
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
		
		if abs(Input.get_joy_axis(player.id, JOY_AXIS_2)) > 0.2 or abs(Input.get_joy_axis(player.id, JOY_AXIS_3)) > 0.2:
			_angle = Vector2(
				-Input.get_joy_axis(player.id, JOY_AXIS_3) if abs(Input.get_joy_axis(player.id, JOY_AXIS_3)) > 0.2 else 0,
				Input.get_joy_axis(player.id, JOY_AXIS_2) if abs(Input.get_joy_axis(player.id, JOY_AXIS_2)) > 0.2 else 0
				).clamped(1)
		
		if _angle.length() > 0:
			_arrow_sprite.rotation = _angle.angle()
			_turret_sprite.rotation = _angle.angle()
		
		if velocity != Vector2.ZERO:
			var _body_angle = Vector2(
			-Input.get_joy_axis(player.id, JOY_AXIS_1) if abs(Input.get_joy_axis(player.id, JOY_AXIS_1)) > 0.2 else 0,
			Input.get_joy_axis(player.id, JOY_AXIS_0) if abs(Input.get_joy_axis(player.id, JOY_AXIS_0)) > 0.2 else 0
			).clamped(1)
			_body_sprite.rotation = _body_angle.angle()
			
		velocity = move_and_slide(velocity*speed*delta)
		
		if Input.is_joy_button_pressed(player.id, JOY_ANALOG_R2):
			if OS.get_ticks_msec() > _next_shot:
				_next_shot = OS.get_ticks_msec() + _fire_cooldown
				_shoot_bullet(_angle)
		
func _shoot_bullet(direction):
	var correct_direction = Vector2(direction.y, -direction.x)
	var bullet = _bullet_scene.instance()
	bullet.velocity = correct_direction * 1000
	bullet.rotation = direction.angle()
	get_parent().add_child(bullet)
	var _gun_angle = correct_direction.angle()
	print(Vector2(cos(_gun_angle), sin(_gun_angle)))
	bullet.position = global_position + Vector2(cos(_gun_angle), sin(_gun_angle))*20
	
func hit():
	queue_free()
