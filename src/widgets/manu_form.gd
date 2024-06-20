extends Control



signal btn_new_game_pressed
signal btn_setting_game_pressed
signal btn_rank_game_pressed
signal btn_quit_game_pressed

@onready var margin_container = %MarginContainer
@onready var w_setting_popup = %w_setting_popup
@onready var w_rank_popup = %w_rank_popup


func _on_btn_new_game_pressed():
	btn_new_game_pressed.emit()


func _on_btn_settings_pressed():
	margin_container.hide()
	w_setting_popup.show()
	btn_setting_game_pressed.emit()


func _on_btn_rank_pressed():
	margin_container.hide()
	w_rank_popup.show()
	btn_rank_game_pressed.emit()
	w_rank_popup.update_rank_board()


func _on_btn_quit_game_pressed():
	btn_quit_game_pressed.emit()


func _on_w_setting_popup_confirm_pressed():
	margin_container.show()
	w_setting_popup.hide()


func _on_w_rank_popup_btn_config_pressed():
	margin_container.show()
	w_rank_popup.hide()
