extends Node2D


@export var min_spawn_rock_time := 1.0
@export var max_spawn_rock_time := 3.0

@onready var plane
@onready var audio_game_over = $Audio_game_over
@onready var game_state_machine :GameStateMachine= %GameStateMachine
@onready var ui_layer = %UILayer
#@onready var game_form = %GameForm

var s_rock = preload("res://src/entities/rock.tscn") #返回路徑，可以從場景那裡拖出來
var s_plane = preload("res://src/entities/plane.tscn")
var current_score :int = 0

var score_timer:Timer = Timer.new()
var timer:Timer = Timer.new()

#初始化程式
func init_game():
	RankBoard.load_rank_board()
	
func ready_game():
	ui_layer.ready_game()

# Called when the node enters the scene tree for the first time.
func _ready():
	game_state_machine.launch()
	timer.timeout.connect(_on_timer_timeout)
	timer.one_shot = true
	timer.wait_time = randf_range(min_spawn_rock_time, max_spawn_rock_time)
	self.add_child(timer)
	timer.start()
	score_timer.timeout.connect(_on_score_timer_timeout)
	self.add_child(score_timer)
	#new_game()

func new_game()->void:
	game_state_machine.set_value('is_new_game', true)
	

func  retry_game()->void:
	
	if not plane:
		plane = s_plane.instantiate()
		plane.position = Vector2(70, 177)
		plane.scale = Vector2(0.5,0.5)
		self.add_child(plane)
	
	current_score = 0
	#game_form.update_socre_display(current_score)
	ui_layer.update_score_display(current_score)
	score_timer.wait_time = 1
	score_timer.start()
	#game_form.retry_game()
	ui_layer.retry_game(current_score)
	
	get_tree().paused = false
	
#退出遊戲
func quit_game():
	game_state_machine.set_value('is_quit_game', true)
	
#退出程式
func end_game():
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not plane:
		return
	if plane.position.y <=0 or plane.position.y >= get_viewport_rect().size.y:
		game_over()



func spawn_rock()->void:
	var a_rock :Node2D= s_rock.instantiate()
	a_rock.rock_entered.connect(_on_rock_entered)
	#print("wait_time:", timer.wait_time)
	var random_choice = randi_range(0,1)
	if random_choice ==0:
		a_rock.position = Vector2(632,randi_range(216,336))
	else:
		a_rock.position = Vector2(632,randi_range(-24,112))
		a_rock.rotation_degrees = 180
	self.add_child(a_rock)

##遊戲失敗
func game_over():
	get_tree().paused = true
	plane.queue_free()
	for rock in get_tree().get_nodes_in_group("rock"):
		rock.queue_free()
		
	if RankBoard.check_rank_board(current_score):
		ui_layer.show_name_input_popup()
	else :
		ui_layer.game_over()
	audio_game_over.play()
	#game_form.game_over()
	
	#print("game over")


	

func _on_timer_timeout()->void:
	spawn_rock()
	timer.wait_time = randf_range(min_spawn_rock_time, max_spawn_rock_time)
	timer.start()
	
func _on_rock_entered()->void:
	game_over()

func _on_score_timer_timeout()->void:
	current_score +=1
	#game_form.update_socre_display(current_score)
	ui_layer.update_score_display(current_score)

func _on_game_form_quit_pressed():
	get_tree().quit()


func _on_game_form_retry_pressed():
	new_game()

func _on_ui_layer_btn_new_game_pressed():
	new_game()

func _on_ui_layer_btn_quit_game_pressed():
	quit_game()


func _on_ui_layer_name_input_popup_confirm(player_name):
	if RankBoard.check_rank_board(current_score):
		RankBoard.update_rank_board(player_name, current_score)


func _on_ui_layer_game_form_quit_game():
	game_state_machine.set_value('is_over_game', true)


func _on_ui_layer_game_form_retry_game():
	game_state_machine.set_value('is_retry_game', true)
