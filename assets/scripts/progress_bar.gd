extends ProgressBar

func _ready() -> void:
	Global.OnSanityChange.connect(changeSanityDisplay)

func changeSanityDisplay(sanityChange: float):
	value += sanityChange
