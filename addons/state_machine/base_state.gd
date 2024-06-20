extends RefCounted
class_name BaseState

var state_machine = null
var agent:Node = null :
	get:    #agent 獲取 state_machine
		assert(state_machine and state_machine.agent, "狀態機或代理不存在")
		return state_machine.agent
		
func _init(machine:BaseStateMachine):
	state_machine = machine
	
func enter(_msg:Dictionary = {}):
	pass
	
func exit():
	pass
	
func update(delta:float)->void:
	pass

func _agent_setter():
	pass

func transform_to(state_index:int, msg:Dictionary={}):
	state_machine.current_state.exit()
	state_machine.current_state_index = state_index
	state_machine.current_state.enter(msg)
