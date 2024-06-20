extends ParallaxBackground

@export var speed:float = 100

#@onready var background: Sprite2D=get_node("ParallaxLayer/Background")
#@onready var background:Sprite2D = $"ParallaxLayer/Background"
#@onready var background = %Background
@onready var parallax_layer = $ParallaxLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	parallax_layer.motion_offset.x -=delta*speed
