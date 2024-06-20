extends MarginContainer

@onready var btn_audio = %btn_audio
@onready var slider_audio = %slider_audio
@onready var btn_music = %btn_music
@onready var slider_music = %slider_music

@export var is_open_audio:bool = true
@export var is_open_music:bool = true
var t_audioOff = preload("res://assets/textures/widgets/icons/audioOff.png")
var t_audioOn = preload("res://assets/textures/widgets/icons/audioOn.png")
var t_musicOff = preload("res://assets/textures/widgets/icons/musicOff.png")
var t_musicOn = preload("res://assets/textures/widgets/icons/musicOn.png")

signal confirm_pressed

func _ready():
	slider_audio.value_changed.connect(_on_slider_audio_value_changed)
	slider_music.value_changed.connect(_on_slider_music_value_changed)
	btn_audio.pressed.connect(_on_btn_audio_pressed)
	btn_music.pressed.connect(_on_btn_music_pressed)
	slider_audio.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	slider_music.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("BGM"))
	set_audio()
	set_music()
			
func set_audio():
	
	btn_audio.texture_normal = t_audioOn if is_open_audio else t_audioOff
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), !is_open_audio)
	
func set_music():
	
	btn_music.texture_normal = t_musicOn if is_open_music else t_musicOff
	AudioServer.set_bus_mute(AudioServer.get_bus_index("BGM"), !is_open_music)

func _on_slider_audio_value_changed(value:float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	
func _on_slider_music_value_changed(value:float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), value)
	
func _on_btn_audio_pressed():
	is_open_audio = not is_open_audio
	set_audio()
	
func _on_btn_music_pressed():
	is_open_music = not is_open_music
	set_music()


func _on_texture_button_pressed():
	confirm_pressed.emit()
