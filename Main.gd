extends Node2D

enum GameState {
	MENU = 0,
	GAME = 1,
	ENDGAME = 2
}
var COLORS = ["#2176ae","#57b8ff","#fe8b71","#fe6a48"]

export var player_icon_scene : PackedScene = preload("res://scenes/TankIcon.tscn")
export var tank_scene : PackedScene = preload("res://scenes/Player.tscn")

var state = GameState.MENU
var players = {}
var _player_icon_instances = {}
var _ready_pressed = []
var _ready_count = 0

func _ready():
	pass


func _process(delta):
	pass
	
	if state == GameState.MENU:
		_process_menu(delta)
		
func _process_menu(delta):
	# input handling
	for id in Input.get_connected_joypads():
		if Input.is_joy_button_pressed(id, JOY_START):
			if not players.has(id):
				_add_player(id)
		if players.has(id):
			if Input.is_joy_button_pressed(id, JOY_BUTTON_1):
				_remove_player(id)
			if Input.is_joy_button_pressed(id, JOY_BUTTON_2):
				if not _ready_pressed.has(id) and players.size() < 4:
					players[id].ready = !players[id].ready
					_ready_count += 1 if players[id].ready else -1
					_player_icon_instances[id].get_node("check").visible = !_player_icon_instances[id].get_node("check").visible
					_ready_pressed.append(id)
					print("ready ", _ready_pressed)
			elif _ready_pressed.has(id):
				_ready_pressed.erase(id)
	# start handling
	if players.size() > 0 and _ready_count == players.size():
		print("all players ready")
		_hide_menu()
		_spawn_players()
		state = GameState.GAME
			
func _add_player(id):
	var player_count = players.size()
	players[id] = Player.new(id, COLORS[player_count])
	
	var player_icon_instance = player_icon_scene.instance()
	add_child(player_icon_instance)
	
	var viewport_width = get_viewport_rect().size.x
	var viewport_height = get_viewport_rect().size.y
	player_icon_instance.position.x = (player_count % 2 * 2 + 1) * viewport_width/4
	player_icon_instance.position.y = viewport_height/4 * 3 if player_count > 2 else viewport_height/4
	player_icon_instance.self_modulate = COLORS[player_count]
	
	_player_icon_instances[id] = (player_icon_instance)
	print(players)
	
func _remove_player(id):
	players.erase(id)
	var player_icon_instance = _player_icon_instances[id]
	remove_child(player_icon_instance)
	player_icon_instance.queue_free()
	_player_icon_instances.erase(id)
	print(players)
	
func _hide_menu():
	for icon in _player_icon_instances.values():
		icon.queue_free()
	_player_icon_instances.clear()
	_ready_count = 0
	
func _spawn_players():
	for i in players:
		var player = players[i]
		
		var tank_instance = tank_scene.instance()
		tank_instance.position = get_node("Spawn_"+str(i+1)).position
		tank_instance.player = player
		tank_instance.movement_enabled = true
		add_child(tank_instance)
		
