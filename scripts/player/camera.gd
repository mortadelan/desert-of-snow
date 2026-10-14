extends Camera3D

# basic fps camera
@export var camera_speed : float = 0.005
# TODO: look into proper sensitivity & fov settings

var rot_x : float = 0
var rot_y : float = 0

@onready var player = await Overlord.get_player()

func _ready():
	rotate_object_local(Vector3.UP, -90.0)

func _unhandled_input(event):
	if player.menu_mode == false:
		if event is InputEventMouseMotion:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			rot_x -= event.screen_relative.x * camera_speed
			rot_y -= event.screen_relative.y * camera_speed
			transform.basis = Basis()
			rotate_object_local(Vector3.UP, rot_x)
			rotate_object_local(Vector3.RIGHT, rot_y)
	elif player.menu_mode == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
