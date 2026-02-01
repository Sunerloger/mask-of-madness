extends Node2D

@onready var wobbleLayer = $CanvasLayer/ColorRect
@onready var darkenLayer = $CanvasModulate
@onready var player = get_tree().get_first_node_in_group("player")
@onready var worldEnv = $WorldEnvironment

func _process(delta: float) -> void:
	var sanity = player.sanity._current_sanity
	var grad_tex: GradientTexture1D = worldEnv.environment.adjustment_color_correction
	var gradient: Gradient = grad_tex.gradient
	var color := gradient.get_color(0)
	
	var brightness := remap(sanity, 0, 100, 0.2, 1)
	var wobbleIntensity := remap(sanity, 0, 100, 40, 500)
	var worldSaturation := remap(sanity, 0, 100, 2, 0.5)
	var redChannel := remap(sanity, 0, 100, 0.1, 0)
	wobbleLayer.material.set_shader_parameter("intensity", wobbleIntensity)
	darkenLayer.color = Color(brightness, brightness, brightness)
	worldEnv.environment.adjustment_saturation = worldSaturation
	color.r = redChannel
	gradient.set_color(0, color)

	player.setConeScale(remap(sanity, 0, 100, player.min_light_cone_scale, player.max_light_cone_scale))
