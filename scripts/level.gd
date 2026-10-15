extends Node3D

enum Floor { SNOW, HARD }

@export var player_pos : Vector3
@export var cam_basis : Basis
@export var floor_type : Floor

func _ready():
	Overlord._on_level_check_in(self)
