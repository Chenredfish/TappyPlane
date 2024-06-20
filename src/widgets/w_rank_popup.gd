extends MarginContainer

@onready var btn_config = %btn_config
@onready var rank_container = %RankContainer

signal btn_config_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	btn_config.pressed.connect(_on_btn_confirm_prossed)

func _on_btn_confirm_prossed():
	btn_config_pressed.emit()

func update_rank_board():
	for i in range(0, RankBoard.rank_board.size()):
		var rank = RankBoard.rank_board[i]
		var w_rank = rank_container.get_child(i)
		w_rank.update_rank(rank.name, rank.score)
