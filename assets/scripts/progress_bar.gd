extends ProgressBar

func _ready() -> void:
	Global.OnSanityChange.connect(changeSanityDisplay)

func changeSanityDisplay(newSanity: float):
	value = newSanity
