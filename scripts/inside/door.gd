extends StaticBody3D

@export var lock : String = ""

@onready var anim = $AnimationPlayer
@onready var door_hole = $door_hole

var player
var open : bool = false

func _ready():
	player = await Overlord.get_player()

# func _on_body_entered(body: Node3D):
# 	if body == player && locked == false && open == false:
# 		anim.play("open")
# 		open = true
# 		await anim.animation_finished
# 		door_hole.set_deferred("disabled", true)

func unlock(key : String = ""):
	if key == lock or lock == "" and open == false:
		# sound here!!!!
		anim.play("open")
		open = true
		await anim.animation_finished
		door_hole.set_deferred("disabled", true)
	elif key != lock:
		pass # and here!!!!!
