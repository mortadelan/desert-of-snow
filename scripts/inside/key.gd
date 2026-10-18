extends Area3D

@export var key : String = ""

@onready var anim = $AnimationPlayer

var player
var once : bool = false

func _ready():
	player = await Overlord.get_player()

func unlock(_key):
	if overlaps_body(player) && once == false:
		anim.play("fade")
		once = true
		player.keyring.append(key)
		# sound effect opportunity!!!!!
