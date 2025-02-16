class_name CardScene
extends Control

func with_data(card_texture : CompressedTexture2D):
	$"Sprite2D".texture = card_texture
	return self
	
func play_arrive() -> void:
	$"CardAnimationPlayer".play("Arrive")

func _ready() -> void:
	pass
