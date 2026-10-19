extends Area3D

@export var lock : String = "lock_thrua!"

@onready var anim = $"../AnimationPlayer"
@onready var mark = $Marker3D

var player
var open : bool = false

func _ready():
	player = await Overlord.get_player()

func unlock(key : String = ""):
	if key == lock and open == false:
		# sound here!!!!
		open = true
		player.cam.reparent(mark)
		player.menu_mode = true
		anim.play("look_up")
		await anim.animation_finished
		get_tree().quit()
	elif key != lock:
		pass # and here!!!!!
