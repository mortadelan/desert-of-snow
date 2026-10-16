extends Area3D

var test_scene = preload("res://scenes/inside/inside.tscn")
@onready var anim = $"../AnimationPlayer"
@onready var vignette = $"../ColorRect"
var player
var scene_changer

func _ready():
	player = await Overlord.get_player()
	scene_changer = await Overlord.get_scene_changer()

func _on_body_entered(body: Node3D):
	if body == player:
		anim.play("open_close")
		vignette.set_visible(true)
		get_tree().set_pause(true)
		await anim.animation_finished
		get_tree().set_pause(false)
		vignette.set_visible(false)
		scene_changer.change_scene(test_scene)
