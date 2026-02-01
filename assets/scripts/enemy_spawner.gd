extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var exit = get_tree().get_first_node_in_group("exit")
@export var roamerEnemy: PackedScene
@export var teleportationEnemy: PackedScene

const NEAR_PLAYER_SPAWN_MIN_RANGE = 800
const NEAR_PLAYER_SPAWN_MAX_RANGE = 1200
const EXIT_SPAWN_MIN_DISTANCE = 300
const EXIT_SPAWN_MAX_DISTANCE = 800
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	spawnEnemy(getRandomEnemyType())
	
func getRandomEnemyType() -> PackedScene:
	var num = rng.randi_range(0, 1)
	match num:
		0:
			return roamerEnemy
		_:
			return teleportationEnemy
	
func spawnEnemy(enemyType: PackedScene) -> void:
	if !enemyType: # checks if packedScene is null
		print("ERROR in Spawner: packedScene is null")
		return
	var enemies_container = get_node("Enemies")
	if !enemies_container:
		print("ERROR in Spawner: enemies_container is null")
		return
	var enemy = enemyType.instantiate()
	var spawn_position = findSpawnPosition()
	print("Spawner: Spawning at (%d, %d) of type %s" % [spawn_position.x, spawn_position.y, enemyType.to_string()])
	enemies_container.add_child(enemy)
	enemy.global_position = spawn_position

func findSpawnPosition():
	return getSpawnPositionNearPlayer()
	#if(player.isNearExit()):
	#	print("Player is near exit. Spawn pos near player")
	#	return getSpawnPositionNearPlayer()
	#else:
	#	print("Player is far from exit. Spawn pos near exit")
	#	return getSpawnPositionNearExit()
	
func getSpawnPositionNearPlayer():
	return getSpawnPositionNearPoint(player.global_position, NEAR_PLAYER_SPAWN_MIN_RANGE, NEAR_PLAYER_SPAWN_MAX_RANGE)

func getSpawnPositionNearExit():
	return getSpawnPositionNearPoint(exit.global_position, EXIT_SPAWN_MIN_DISTANCE, EXIT_SPAWN_MAX_DISTANCE)

func getSpawnPositionNearPoint(point: Vector2, min_distance: float, max_distance: float) -> Vector2:
	var angle := rng.randf() * TAU
	var distance := rng.randf_range(min_distance, max_distance)
	var offset := Vector2(distance, 0).rotated(angle)
	return point + offset
