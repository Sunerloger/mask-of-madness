extends Node2D


const PICKUP_SCENE = preload("res://scenes/sanityPickup.tscn")

@export var occlusion_layer_id := 0
@export var max_tries := 60

@onready var rng := RandomNumberGenerator.new()

@onready var spawn_volume: Area2D = $"../../SpawnVolume"
@onready var tm: TileMapLayer = $"../../CanvasGroup/TileMapLayer"

func _ready() -> void:
	rng.randomize()

func _on_timer_timeout() -> void:
	spawn()

func is_occluded_at_global_pos(global_p: Vector2) -> bool:
	var cell := tm.local_to_map(tm.to_local(global_p))
	var td := tm.get_cell_tile_data(cell)
	return td != null and td.get_occluder_polygons_count(occlusion_layer_id) > 0
	
func random_point_in_area_global(a: Area2D) -> Variant:
	var collider := a.get_node_or_null("CollisionShape2D") as CollisionShape2D
	if collider == null or collider.shape == null:
		return null

	var rect_shape := collider.shape as RectangleShape2D
	if rect_shape == null:
		return null

	var half := rect_shape.size * 0.5
	var local_pt := Vector2(
		rng.randf_range(-half.x, half.x),
		rng.randf_range(-half.y, half.y)
	)

	return collider.to_global(local_pt)

func find_spawn_pos() -> Variant:
	for _i in range(max_tries):
		var p = random_point_in_area_global(spawn_volume)
		if p != null and not is_occluded_at_global_pos(p):
			return p
	return null

func spawn() -> void:
	var pos = find_spawn_pos()
	if pos == null:
		return

	var n := PICKUP_SCENE.instantiate() as Node2D
	n.global_position = pos
	get_parent().get_parent().get_node("Spawnables").add_child(n)
