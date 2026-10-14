extends Node

signal player_check_in(player : Node)
signal hud_check_in(hud : Node)

var player : Node
var hud : Node

func _on_player_check_in(check_in : Node):
	player = check_in
	player_check_in.emit(player)

func _on_hud_check_in(check_in : Node):
	hud = check_in
	hud_check_in.emit(hud)

func get_player():
	if player == null:
		await player_check_in
	return player

func get_hud():
	if hud == null:
		await hud_check_in
	return hud
