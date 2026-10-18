extends CharacterBody3D

@export var walk_speed: float = 15.0
@export var initial_state = State.WALK
@export var menu_mode : bool = true
@export var keyring : Array[String]

var footsteps_snow = preload("res://art/player/footsteps_snow.tres")
var footsteps_hard = preload("res://art/player/footsteps_hard.tres")

@onready var pivot = $pivot
@onready var cam = $pivot/Camera3D
@onready var flashlight = $pivot/Camera3D/flashligght
@onready var raycast = $pivot/Camera3D/RayCast3D
@onready var audio : AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var footstep_timer = $FootstepTimer

var hud : Node
var level : Node
var scene_changer : Node

const FOOTSTEP_INTERVAL = 0.4

enum State { WALK, RUN, LOAD }
var current_state = initial_state
var last_state = current_state

func _ready():
	hud = await Overlord.get_hud()
	_on_level_changed(await Overlord.get_level())
	Overlord._on_player_check_in(self)
	scene_changer = await Overlord.get_scene_changer()
	scene_changer.connect("level_changed", _on_level_changed)

func _on_level_changed(new_level):
	level = new_level
	if level.floor_type == level.Floor.SNOW:
		audio.stream = footsteps_snow
		audio.volume_db = -45.0
	elif level.floor_type == level.Floor.HARD:
		audio.stream = footsteps_hard
		audio.volume_db = 0.0

func _physics_process(_delta):
	if menu_mode == false:
		var input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
		var direction = (cam.transform.basis * pivot.transform.basis * \
		  Vector3(input_direction.x, 0, input_direction.y)).normalized()
		if not self.is_on_floor():
			velocity.y += -2.0
		velocity.x = direction.x * walk_speed
		velocity.z = direction.z * walk_speed
		if abs(velocity.x) > 0.01 and abs(velocity.z) > 0.01:
			if footstep_timer.is_stopped():
				audio.play()
				footstep_timer.start(FOOTSTEP_INTERVAL)
		move_and_slide()

func _unhandled_key_input(event):
	if menu_mode == false:
		if event.is_action_pressed("load_mode"):
			change_state(State.LOAD)
			handle_state()
		if event.is_action_pressed("run"):
			change_state(State.RUN)
			handle_state()
		if event.is_action_pressed("switch_flashlight"):
			flashlight.pull_out()
#			flashlight.switch()
		if event.is_action_pressed("menu_mode"):
			hud.set_visible(true)
			menu_mode = true
			get_tree().set_pause(true)
		if event.is_action_pressed("interact"):
			open_door()

func open_door():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		print("blah: ", collider)
		if collider.has_method("unlock"):
			print("bleh")
			for key in keyring:
				collider.unlock(key)

func change_state(to: State = last_state):
	if to == current_state and to != State.RUN:
		current_state = last_state
		last_state = current_state
	elif to == current_state and to == State.RUN:
		last_state = current_state
		current_state = State.WALK
	else:
		last_state = current_state
		current_state = to

func handle_state():
	match current_state:
		State.RUN:
			walk_speed = 25.0
		State.WALK:
			walk_speed = 15.0
		State.LOAD:
			walk_speed = 5.0

func _on_menu_change(change : bool):
	menu_mode = change
