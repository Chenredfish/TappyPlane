extends BaseStateMachine
class_name GameStateMachine


enum GAME_STATE_TYPE{
	INIT, ##遊戲初始化狀態
	READY, ##準備介面狀態
	PLAYING, ##遊戲正在進行狀態
	PAUSE, ##遊戲暫停狀態
	END, ##遊戲結束狀態
}

class InitState:
	extends BaseState
	
	func enter(_msg:Dictionary = {}):
		print("進入init狀態")
		agent.init_game()
		transform_to(GAME_STATE_TYPE.READY)

class ReadyState:
	extends BaseState
	var is_new_game:bool = false
	var is_quit_game:bool = false
	
	func enter(_msg:Dictionary = {}):
		print("進入ready狀態")
		agent.ready_game()
		
	func exit()->void:
		state_machine.set_value('is_new_game', false)
		state_machine.set_value('is_quit_game', false)
		
	func update(delta):
		
		if state_machine.has_value('is_new_game'):
			is_new_game = state_machine.get_value('is_new_game')
			
		if state_machine.has_value('is_quit_game'):
			is_quit_game = state_machine.get_value('is_quit_game')
		if is_new_game:
			transform_to(GAME_STATE_TYPE.PLAYING)
		if is_quit_game:
			transform_to(GAME_STATE_TYPE.END)
	
class PlayingState:
	extends BaseState
	
	var is_over_game :bool = false
	var is_retry_game:bool = false
	
	func enter(_msg:Dictionary = {}):
		print("")
		agent.retry_game()
		
	func exit():
		state_machine.set_value('is_over_game', false)
		state_machine.set_value('is_retry_game', false)
		
		
	func update(delta):
		if state_machine.has_value('is_over_game'):
			is_over_game = state_machine.get_value('is_over_game')
		if is_over_game:
			transform_to(GAME_STATE_TYPE.READY)
		
		if state_machine.has_value('is_retry_game'):
			is_retry_game = state_machine.get_value('is_retry_game')
		if is_retry_game:
			transform_to(GAME_STATE_TYPE.PLAYING)
	
class PauseState:
	extends BaseState
	
class EndState:
	extends BaseState
	
	func enter(_msg:Dictionary = {}):
		print("進入END狀態")
		agent.end_game()
	
func _ready():
	add_state(GAME_STATE_TYPE.INIT, InitState.new(self))
	add_state(GAME_STATE_TYPE.READY, ReadyState.new(self))
	add_state(GAME_STATE_TYPE.PLAYING, PlayingState.new(self))
	add_state(GAME_STATE_TYPE.PAUSE, PauseState.new(self))
	add_state(GAME_STATE_TYPE.END, EndState.new(self))
