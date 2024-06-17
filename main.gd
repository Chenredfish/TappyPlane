extends Node2D

var timer:Timer = Timer.new()
@export var min_spawn_rock_time := 1.0
@export var max_spawn_rock_time := 3.0

var s_rock = preload("res://src/entities/rock.tscn") #返回路徑，可以從場景那裡拖出來

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = randf_range(min_spawn_rock_time, max_spawn_rock_time)
	self.add_child(timer)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout()->void:
	spawn_rock()
	timer.wait_time = randf_range(min_spawn_rock_time, max_spawn_rock_time)
	timer.start()

func spawn_rock()->void:
	#print("wait_time:", timer.wait_time)
	var a_rock :Node2D= s_rock.instantiate()
	a_rock.position = Vector2(632,216)
	self.add_child(a_rock)
