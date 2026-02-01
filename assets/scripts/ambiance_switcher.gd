extends Node2D


@export var tracks: Dictionary = {
	"sanity1": preload("res://assets/sounds/sanity_1.mp3"),
	"sanity2": preload("res://assets/sounds/sanity_2.mp3"),
	"sanity3": preload("res://assets/sounds/sanity_3.mp3"),
	"sanity4": preload("res://assets/sounds/sanity_4.mp3")
}

@export var fade_time := 2.0
@export var target_db := -15
@export var silent_db := -80.0

@onready var ambiance_1: AudioStreamPlayer = $Ambiance1
@onready var ambiance_2: AudioStreamPlayer = $Ambiance2

var _max_sanity: float
var _current_sanity_level: int

var _active: AudioStreamPlayer
var _inactive: AudioStreamPlayer
var _tween: Tween


func _ready() -> void:
	_active = ambiance_1
	_inactive = ambiance_2
	_active.volume_db = target_db
	_inactive.volume_db = silent_db
	
	Global.OnCurrentSanityChange.connect(_curr_sanity_changed)
	Global.OnMaxSanityChange.connect(_max_sanity_changed)
	

func _curr_sanity_changed(new_curr_sanity: float):
	var sanity_percent := new_curr_sanity / _max_sanity
	
	if sanity_percent <= 0.25:
		_current_sanity_level = 4
	elif sanity_percent <= 0.5:
		_current_sanity_level = 3
	elif sanity_percent <= 0.75:
		_current_sanity_level = 2
	else:
		_current_sanity_level = 1
		
	_update_audio()


func _max_sanity_changed(new_max_sanity: float):
	_max_sanity = new_max_sanity


func _update_audio() -> void:
	var stream_name := "sanity" + str(_current_sanity_level)
	var stream: AudioStream = tracks.get(stream_name, null)
	if stream == null:
		return

	# track already playing
	if _active.playing and _active.stream == stream:
		return
		
	if _tween and _tween.is_running() and _inactive.stream == stream:
		return

	if _tween and _tween.is_running():
		_tween.kill()

	# prepare next track in inactive
	_inactive.stop()
	_inactive.stream = stream
	_inactive.volume_db = silent_db
	_inactive.play()

	_tween = create_tween()
	_tween.tween_property(_inactive, "volume_db", target_db, fade_time)
	_tween.parallel().tween_property(_active, "volume_db", silent_db, fade_time)
	_tween.finished.connect(
		func():
			_active.stop()
			var tmp := _active
			_active = _inactive
			_inactive = tmp
	)
