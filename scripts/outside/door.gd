extends StaticBody3D

@export var scene = preload("res://scenes/inside/inside.tscn")
@export var lock : String = ""

@onready var anim = $AnimationPlayer

var player
var scene_changer

func _ready():
	player = await Overlord.get_player()
	scene_changer = await Overlord.get_scene_changer()

# func _on_body_entered(body: Node3D):
# 	if body == player:
# 		anim.play("open_close")

func unlock(key : String = ""):
	if key == lock or lock == "":
		# sound here!!!!
		anim.play("open_close")
		await anim.animation_finished
		scene_changer.change_scene(scene)
	elif key != lock:
		pass # and here!!!!!
