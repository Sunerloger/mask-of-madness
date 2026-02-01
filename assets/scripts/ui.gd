extends Control

@onready var player := get_tree().get_first_node_in_group("player")
@onready var player_mask := $player_mask
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var sanity = player.sanity._current_sanity
	if (60 < sanity && sanity < 80):
		player_mask.frame = 1		
	elif (40 < sanity && sanity < 60):
		player_mask.frame = 2
	elif (20 < sanity && sanity < 40):
		player_mask.frame = 3
	elif (sanity < 20):
		player_mask.frame = 4
