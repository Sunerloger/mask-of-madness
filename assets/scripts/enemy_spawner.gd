extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@export var roamerEnemy: PackedScene
@export var teleportationEnemy: PackedScene

const SPAWN_MIN_RANGE = 400
const SPAWN_MAX_RANGE = 1800
var enemies := []
var max_enemies := 3
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if !shouldSpawn():
		# print("Spawner: should not spawn (max enemies)")
		return
	spawnEnemy(getRandomEnemyType())
	
func getRandomEnemyType() -> PackedScene:
	var num = rng.randi_range(0, 1)
	match num:
		0:
			return roamerEnemy
		_:
			return teleportationEnemy
	
func shouldSpawn() -> bool:
	return enemies.size() < max_enemies
	
func spawnEnemy(enemyType: PackedScene) -> void:
	if !enemyType: # checks if packedScene is null
		print("ERROR in Spawner: packedScene is null")
		return
	var enemy = enemyType.instantiate()
	var spawn_position = findSpawnPosition()
	enemy.global_position = spawn_position
	print("Spawner: Spawning at (%d, %d) of type %s" % [spawn_position.x, spawn_position.y, enemyType.to_string()])
	get_parent().add_child(enemy)
	enemies.append(enemy)

func findSpawnPosition():
	var angle := randf() * TAU
	var distance := randf_range(SPAWN_MIN_RANGE, SPAWN_MAX_RANGE)
	var offset := Vector2(distance, 0).rotated(angle)
	# TODO check if spawn position is outside an object
	return player.global_position + offset
	
