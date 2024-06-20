extends MarginContainer

@onready var te_name = %te_name
@onready var btn_quit = %btn_quit
@onready var btn_confirm = %btn_confirm

signal btn_quit_pressed
signal btn_confirm_pressed(player_name:String)

# Called when the node enters the scene tree for the first time.
func _ready():
	btn_quit.pressed.connect(_on_btn_quit_pressed)
	btn_confirm.pressed.connect(_on_btn_confirm_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_btn_quit_pressed():
	btn_quit_pressed.emit()
	self.hide()
	
func _on_btn_confirm_pressed():
	if te_name.text.is_empty():
		return
	btn_confirm_pressed.emit(te_name.text)
	self.hide()
