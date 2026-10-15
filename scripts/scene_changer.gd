extends Node3D

signal scene_changed(current_scene)
signal level_changed(current_level)

@export var initial_scene : PackedScene = preload("res://scenes/outside.tscn")
@export var player_scene : PackedScene = preload("res://scenes/player/player.tscn")

var current_scene : PackedScene = initial_scene
var current_level : Node
var player : Node

func _ready():
	Overlord._on_scene_changer_check_in(self)
	spawn_scenes()

func spawn_scenes():
	current_level = current_scene.instantiate()
	add_child(current_level)
	scene_changed.emit(current_scene)
	if player == null:
		player = player_scene.instantiate()
		add_child(player)
	player.position = current_level.player_pos
	player.pivot.basis = current_level.cam_basis
	level_changed.emit(current_level)

func free_level():
	current_level.queue_free()

func change_scene(new_scene : PackedScene):
	free_level()
	current_scene = new_scene
	spawn_scenes()
