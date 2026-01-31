extends ProgressBar


func _ready() -> void:
	Global.OnCurrentSanityChange.connect(changeCurrentSanityDisplay)
	Global.OnMaxSanityChange.connect(changeMaxSanityDisplay)


func changeCurrentSanityDisplay(new_current_sanity: float):
	value = new_current_sanity
	
	
func changeMaxSanityDisplay(new_max_sanity: float):
	max_value = max(0, new_max_sanity)
