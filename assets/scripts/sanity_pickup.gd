extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var leaves_particles: GPUParticles2D = $leaves_particles
@onready var shadow: Sprite2D = $shadow
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var is_destroyed: bool = false

func _ready() -> void:
	sprite_2d.material.light_mode = 2
	leaves_particles.material.light_mode = 2
	shadow.material.light_mode = 2
	modulate.a = 0.0
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(self,"modulate:a", 1.0, 1.0)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_destroyed:
		is_destroyed = true
		var sanity = body.get_node("Sanity")
		sanity.update_current_sanity(5)
		
		visible = false
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		queue_free()


func _on_despawn_timer_timeout() -> void:
	queue_free()
