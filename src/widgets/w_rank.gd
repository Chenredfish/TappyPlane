extends MarginContainer

#const t_MEDAL_BRONZE = preload("res://assets/textures/widgets/icons/medalBronze.png")
#const t_MEDAL_GOLD = preload("res://assets/textures/widgets/icons/medalGold.png")
#const t_MEDAL_SILVER = preload("res://assets/textures/widgets/icons/medalSilver.png")

@onready var lab_name = %lab_name
@onready var lab_score = %lab_score
@onready var tr_medal = %tr_medal
@onready var label = %Label
@onready var margin_container = %MarginContainer

@export var medal_texture : Texture = null
# Called when the node enters the scene tree for the first time.
func _ready():
	tr_medal.texture = medal_texture

func update_rank(name:String, score:int):
	if score !=0 and score !=null:
		label.hide()
		margin_container.show()
		lab_name.text = "name: " + name
		lab_score.text = "score: " + str(score)
	else:
		label.show()
		margin_container.hide()
