extends MeshInstance3D

@onready var player = await Overlord.get_player()

func _physics_process(_delta):
	if Vector2(position.x, position.z).distance_to( \
	   Vector2(player.position.x, player.position.z)) >= 400:
		position = position.move_toward(Vector3(player.position.x, 0, player.position.z), 100)
