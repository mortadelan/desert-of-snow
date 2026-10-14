extends Control

@onready var player = await Overlord.get_player()

func _ready():
	Overlord._on_hud_check_in(self)

func _on_exit_button_pressed() -> void:
	pass # Replace with function body.

func _on_options_button_pressed() -> void:
	pass # Replace with function body.

func _on_start_button_pressed() -> void:
	self.set_visible(false)
	player._on_menu_change(false)
