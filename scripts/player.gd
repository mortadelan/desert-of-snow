extends CharacterBody3D

@export var walk_speed: float = 15.0
@export var initial_state = State.WALK
@export var menu_mode : bool = true

@onready var cam = $Camera3D
@onready var flashlight = $Camera3D/flashligght
@onready var hud = await Overlord.get_hud()

enum State { WALK, RUN, LOAD }
var current_state = initial_state
var last_state = current_state

func _ready():
	Overlord._on_player_check_in(get_node("../player"))

func _physics_process(_delta):
	if menu_mode == false:
		var input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
		var direction = (cam.transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
		if not self.is_on_floor():
			velocity.y += -2.0
		velocity.x = direction.x * walk_speed
		velocity.z = direction.z * walk_speed
		#	if velocity != Vector3.ZERO:
		#		body.rotation.y = move_toward(body.rotation.y, (cam.rotation.y + TAU / 4), 0.1)
		move_and_slide()

func _unhandled_key_input(event):
	if menu_mode == false:
		if event.is_action_pressed("load_mode"):
			change_state(State.LOAD)
			handle_state()
		if event.is_action_pressed("run"):
			change_state(State.RUN)
			handle_state()
		if event.is_action_pressed("pull_out_flashlight"):
			flashlight.pull_out()
		if event.is_action_pressed("switch_flashlight"):
			flashlight.switch()
		if event.is_action_pressed("menu_mode"):
			# another opportunity for an animation, vignette coming down maybe
			hud.set_visible(true)
			menu_mode = true

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
