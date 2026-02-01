extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var leaves_particles: GPUParticles2D = $leaves_particles
@onready var shadow: Sprite2D = $shadow

func _ready() -> void:
	sprite_2d.material.light_mode = 2
	leaves_particles.material.light_mode = 2
	shadow.material.light_mode = 2
	modulate.a = 0.0
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(self,"modulate:a", 1.0, 1.0)
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var health := body.get_node("Health")
		health.update_current_health(5)
		queue_free()


func _on_despawn_timer_timeout() -> void:
	queue_free()
