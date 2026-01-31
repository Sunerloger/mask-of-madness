extends Node2D

@onready var wobbleLayer = $CanvasLayer/ColorRect
@onready var darkenLayer = $CanvasModulate
@onready var player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	var sanity = player.sanity._current_sanity
	
	var brightness := remap(sanity, 0, 100, 0.5, 1)
	
	darkenLayer.color = Color(brightness, brightness, brightness)
	return
