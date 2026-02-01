extends Control

@onready var menuSound = $Ambiance1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(GlobalSettings.gameStarted):
		menuSound.volume_db = -80
	else:
		menuSound.volume_db = GlobalSettings.target_db_master
