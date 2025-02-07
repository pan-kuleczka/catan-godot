class_name Building
extends Resource

var player_color : int

func _init(_player_color : int) -> void:
	player_color = _player_color

func get_texture():
	push_error("The function get_texture() has not been overriden in a subclass of Building")
