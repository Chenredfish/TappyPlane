extends Node
class_name BaseStateMachine

var current_state_index:int = 0
var current_state:BaseState:
	get:
		return states[current_state_index]

var states:Dictionary={}

##狀態機代理
@export var agent:Node #沒有給予初始狀態就爆錯

var is_run:bool = false

var values:Dictionary={}


func _enter_tree():
	self.process_mode = PROCESS_MODE_ALWAYS

func _process(delta)->void:
	current_state.update(delta)

func launch(state_index:int = 0):
	assert(agent, '代理不能為空') #assert第一項如果為false，程式直接停止
	is_run=true
	
	#current_state = states[state_index]
	current_state.enter()
	
	
"""
1.增加
2.刪除
3.改動
4.查看
"""

func add_state(state_type:int, state:BaseState)->void:
	states[state_type] = state

func set_value(name:StringName, value:Variant): #Variant自由的變數，會自己更改
	values[name]=value

func get_value(name:StringName)->Variant:
	if values.has(name):
		return values[name]
	else:
		return null

func has_value(name:StringName)->bool:
	return values.has(name)
