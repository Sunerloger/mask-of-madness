extends PointLight2D

@onready var exit := get_tree().get_first_node_in_group("exit")
@onready var player := get_tree().get_first_node_in_group("player")
@onready var camera := get_viewport().get_camera_2d()

@export var edge_margin := -100 # how far from the screen edge the light stays

func _process(delta: float) -> void:
	if not exit or not player or not camera:
		return

	var sanity = player.sanity._current_sanity
	var intensity := remap(sanity, 0, 100, 0.7, 0)
	energy = intensity
	
	# World-space direction from player to goal
	var direction = (exit.global_position - player.global_position).normalized()

	# Get viewport size
	var viewport_size = get_viewport_rect().size

	var half_size = viewport_size * 0.5
	var target_screen_pos = half_size + direction * (half_size - Vector2(edge_margin, edge_margin))

	# Screen → world conversion (Godot 4 correct way)
	look_at(player.global_position)
	global_position = get_viewport().get_canvas_transform().affine_inverse() * target_screen_pos
