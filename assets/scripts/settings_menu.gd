extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$GoalHelp.button_pressed = GlobalSettings.goal_help_setting_pressed
	$MasterVol.value = GlobalSettings.target_db_master

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/startMenu.tscn")


func _on_goal_help_toggled(toggled_on: bool) -> void:
	GlobalSettings.goal_help_setting_pressed = toggled_on


func _on_h_slider_value_changed(value: float) -> void:
	print(value)
	GlobalSettings.target_db_master = value
