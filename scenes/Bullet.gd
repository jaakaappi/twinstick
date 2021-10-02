extends KinematicBody2D

var velocity = Vector2(0, 0)

var _explosion_scene: PackedScene = preload("res://scenes/Explosion.tscn")

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var explosion : AnimatedSprite = _explosion_scene.instance()
		get_parent().add_child(explosion)
		explosion.position = collision_info.position
		explosion.play()
		if collision_info.collider.has_method("hit"):
			collision_info.collider.hit()
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

