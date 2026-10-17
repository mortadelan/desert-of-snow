extends Node3D

var state : bool = false

@onready var light = $SpotLight3D
@onready var anim = $AnimationPlayer

func _ready():
	self.set_visible(false)
	light.set_visible(false)
	anim.play_section_with_markers(
	  "out_and_back", "start_put_back", "end_put_back")
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
		anim.play_section_with_markers(
		  "out_and_back", "start_put_back", "end_put_back")
		light.set_visible(false)
		await anim.animation_finished
		self.set_visible(false)
	else:
		self.set_visible(true)
		anim.play_section_with_markers(
		  "out_and_back", "start_pull_out", "start_put_back")
		light.set_visible(true)
		await anim.animation_finished

# func _physics_process(_delta):
#   jiggle about while moved
