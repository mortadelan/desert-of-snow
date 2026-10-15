extends Area3D

var test_scene = load("res://test.tscn")
var player
var scene_changer

func _ready():
	player = await Overlord.get_player()
	scene_changer = await Overlord.get_scene_changer()

func _on_body_entered(body: Node3D):
	if body == player:
		scene_changer.change_scene(test_scene)
