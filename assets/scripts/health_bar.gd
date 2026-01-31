extends ProgressBar


func _ready() -> void:
	Global.OnCurrentHealthChange.connect(changeCurrentHealthDisplay)
	Global.OnMaxHealthChange.connect(changeMaxHealthDisplay)


func changeCurrentHealthDisplay(new_current_health: float):
	value = new_current_health


func changeMaxHealthDisplay(new_max_health: float):
	max_value = max(0, new_max_health)
