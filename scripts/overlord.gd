extends Node

signal player_check_in(player : Node)
signal hud_check_in(hud : Node)
signal level_check_in(level : Node)
signal scene_changer_check_in(scene_changer : Node)

var player : Node
var hud : Node
var level : Node
var scene_changer : Node

func _on_player_check_in(check_in : Node):
	player = check_in
	player_check_in.emit(player)

func _on_hud_check_in(check_in : Node):
	hud = check_in
	hud_check_in.emit(hud)

func _on_level_check_in(check_in : Node):
	level = check_in
	level_check_in.emit(level)

func _on_scene_changer_check_in(check_in :Node):
	scene_changer = check_in
	scene_changer_check_in.emit(scene_changer)

func get_player():
	if player == null:
		await player_check_in
	return player

func get_hud():
	if hud == null:
		await hud_check_in
	return hud

func get_level():
	if level == null:
		await level_check_in
	return level

func get_scene_changer():
	if scene_changer == null:
		await scene_changer_check_in
	return scene_changer
