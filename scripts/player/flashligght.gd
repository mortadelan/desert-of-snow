extends Node3D

var state : bool = false

@onready var light = $SpotLight3D

var test_scene = load("res://test.tscn")
var scene_changer

func _ready():
	self.set_visible(false)
	scene_changer = await Overlord.get_scene_changer()

func switch():
	# sound effect for flicking on/off?
	if self.is_visible():
		if state == false:
			state = true
			light.set_visible(state)
		else:
			state = false
			light.set_visible(state)
func pull_out():
	# maybe a little animation could play aswell, idk
	# and maybe a sound!
	if self.is_visible():
		self.set_visible(false)
		light.set_visible(false)
		scene_changer.change_scene(test_scene)
	else:
		self.set_visible(true)
		light.set_visible(state)

# func _physics_process(_delta):
#   jiggle about while moved
