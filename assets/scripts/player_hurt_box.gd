extends Area2D

var _touching_enemies: Array[EnemyBase] = []
var _invulnerable: bool = false

@onready var _invuln_timer: Timer = $InvulnTimer
	
func _on_body_entered(body: Node2D) -> void:
	var enemy := body as EnemyBase
	if enemy:
		_touching_enemies.append(enemy)
		_try_take_touch_damage()
		
func _on_body_exited(body: Node2D) -> void:
	var enemy := body as EnemyBase
	if enemy:
		_touching_enemies.erase(enemy)

func _try_take_touch_damage() -> void:
	if _invulnerable or _touching_enemies.is_empty():
		return

	var total := 0
	for e in _touching_enemies:
		if is_instance_valid(e):
			total += e.get_strength()

	var healthNode = get_parent().get_node("Health")
	healthNode.update_current_health(-total)

	_invulnerable = true
	_invuln_timer.start()

func _on_invuln_timer_timeout() -> void:
	_invulnerable = false
	_try_take_touch_damage()
