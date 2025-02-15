extends Control

func with_data(card_texture : CompressedTexture2D):
	$"Sprite2D".texture = card_texture
	return self

func _ready() -> void:
	pass
