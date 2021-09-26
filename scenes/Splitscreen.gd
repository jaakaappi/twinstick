extends Node

onready var viewport1 = $HBoxContainer1/VBoxContainer1/ViewportContainer1/Viewport1
onready var viewport2 = $HBoxContainer1/VBoxContainer1/ViewportContainer2/Viewport2
onready var viewport3 = $HBoxContainer1/VBoxContainer2/ViewportContainer3/Viewport3
onready var viewport4 = $HBoxContainer1/VBoxContainer2/ViewportContainer4/Viewport4
onready var camera1 = $HBoxContainer1/VBoxContainer1/ViewportContainer1/Viewport1/Camera2D
onready var camera2 = $HBoxContainer1/VBoxContainer1/ViewportContainer2/Viewport2/Camera2D
onready var camera3 = $HBoxContainer1/VBoxContainer2/ViewportContainer3/Viewport3/Camera2D
onready var camera4 = $HBoxContainer1/VBoxContainer2/ViewportContainer4/Viewport4/Camera2D
onready var world = $HBoxContainer1/VBoxContainer1/ViewportContainer1/Viewport1/TileMap


func _ready():
	viewport2.world_2d = viewport1.world_2d
	viewport3.world_2d = viewport1.world_2d
	viewport4.world_2d = viewport1.world_2d
