extends Node2D


@export var min_spawn_rock_time := 1.0
@export var max_spawn_rock_time := 3.0

@onready var plane = %plane
@onready var game_form = %GameForm


var s_rock = preload("res://src/entities/rock.tscn") #返回路徑，可以從場景那裡拖出來
var current_score :int = 0

var score_timer:Timer = Timer.new()
var timer:Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_timer_timeout)
	timer.one_shot = true
	timer.wait_time = randf_range(min_spawn_rock_time, max_spawn_rock_time)
	self.add_child(timer)
	timer.start()
	score_timer.timeout.connect(_on_score_timer_timeout)
	score_timer.wait_time = 1
	self.add_child(score_timer)
	score_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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

func game_over():
	get_tree().paused = true
	plane.queue_free()
	for rock in get_tree().get_nodes_in_group("rock"):
		rock.queue_free()
		
	print("game over")


	

func _on_timer_timeout()->void:
	spawn_rock()
	timer.wait_time = randf_range(min_spawn_rock_time, max_spawn_rock_time)
	timer.start()
	
func _on_rock_entered()->void:
	game_over()

func _on_score_timer_timeout()->void:
	current_score +=1
	game_form.update_socre_display(current_score)
