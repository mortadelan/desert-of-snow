extends Area3D

@onready var anim = $AnimationPlayer

var player : Node
var once : bool = false

func _ready():
	player = await Overlord.get_player()

func _on_body_entered(body : Node3D):
	if body == player && once == false:
		anim.play("tip_fade")
		once = true
