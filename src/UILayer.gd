extends CanvasLayer

@onready var game_form = %GameForm
@onready var manu_form = $ManuForm

signal btn_new_game_pressed
signal btn_quit_game_pressed
signal name_input_popup_confirm(player_name:String)
signal game_form_retry_game
signal game_form_quit_game


func ready_game():
	manu_form.show()
	game_form.hide()
	
func retry_game(current_score:int):
	manu_form.hide()
	game_form.show()
	game_form.retry_game()
	
	
func update_score_display(current_score:int):
	game_form.update_socre_display(current_score)
	
func game_over():
	game_form.game_over()

func _on_manu_form_btn_new_game_pressed():
	btn_new_game_pressed.emit()

#顯示玩家輸入UI
func show_name_input_popup():
	game_form.show_name_input_popup()

func _on_manu_form_btn_quit_game_pressed():
	btn_quit_game_pressed.emit()


func _on_manu_form_btn_rank_game_pressed():
	pass # Replace with function body.


func _on_manu_form_btn_setting_game_pressed():
	pass # Replace with function body.


func _on_game_form_name_input_popup_confirm(player_name:String):
	name_input_popup_confirm.emit(player_name)


func _on_game_form_quit_pressed():
	game_form_quit_game.emit()


func _on_game_form_retry_pressed():
	game_form_retry_game.emit()
