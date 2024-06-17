extends Control

@onready var score_container = %ScoreContainer

var number_texture:=[
	preload("res://assets/textures/widgets/numbers/number0.png"),
	preload("res://assets/textures/widgets/numbers/number1.png"),
	preload("res://assets/textures/widgets/numbers/number2.png"),
	preload("res://assets/textures/widgets/numbers/number3.png"),
	preload("res://assets/textures/widgets/numbers/number4.png"),
	preload("res://assets/textures/widgets/numbers/number5.png"),
	preload("res://assets/textures/widgets/numbers/number6.png"),
	preload("res://assets/textures/widgets/numbers/number7.png"),
	preload("res://assets/textures/widgets/numbers/number8.png"),
	preload("res://assets/textures/widgets/numbers/number9.png"),
]

func update_socre_display(current_score:int)->void:
	var score_str:String = str(current_score)
	var digit_count = score_str.length()
	
	for i in digit_count:
		var digit:int = int(score_str[i])
		var digit_spirit:TextureRect
		if score_container.get_child_count() <=i: #位數超過了，就建立新的TextureRect來調整
			digit_spirit = TextureRect.new()
			score_container.add_child(digit_spirit)
		else:
			digit_spirit = score_container.get_child(i) #調整第幾位的數字

		digit_spirit.texture = number_texture[digit] #將照片放入，也就是上面的調整數字
