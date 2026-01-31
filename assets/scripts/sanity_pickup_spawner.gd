extends Node2D


const PICKUP_SCENE = preload("res://scenes/sanityPickup.tscn")

@export var occlusion_layer_id := 0
@export var max_tries := 60

@onready var rng := RandomNumberGenerator.new()

@onready var spawn_poly: Polygon2D = $"../../Polygon2D"
@onready var tm: TileMapLayer = $"../../CanvasGroup/TileMapLayer"

func _ready() -> void:
	rng.randomize()

func _on_timer_timeout() -> void:
	spawn()

func random_point_in_polygon_global(p: Polygon2D):
	var poly := p.polygon
	if poly.size() < 3:
		return p.global_position

	# local AABB
	var min_v := poly[0]
	var max_v := poly[0]
	for v in poly:
		min_v = Vector2(min(min_v.x, v.x), min(min_v.y, v.y))
		max_v = Vector2(max(max_v.x, v.x), max(max_v.y, v.y))

	for _i in range(max_tries):
		var local_pt := Vector2(
			rng.randf_range(min_v.x, max_v.x),
			rng.randf_range(min_v.y, max_v.y)
		)
		if Geometry2D.is_point_in_polygon(local_pt, poly):
			return p.to_global(local_pt)

func is_occluded_at_global_pos(global_p: Vector2) -> bool:
	var cell := tm.local_to_map(tm.to_local(global_p))
	var td := tm.get_cell_tile_data(cell)
	return td != null and td.get_occluder_polygons_count(occlusion_layer_id) > 0

func find_spawn_pos():
	for _i in range(max_tries):
		var p = random_point_in_polygon_global(spawn_poly)
		if p and not is_occluded_at_global_pos(p):
			return p

func spawn():
	var n := PICKUP_SCENE.instantiate() as Node2D
	var pos = find_spawn_pos()
	if pos:
		n.global_position = pos
		get_parent().get_parent().get_node("Spawnables").add_child(n)
