extends CharacterBody2D

@onready var audio_stream_player = $AudioStreamPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity :int = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var min_tilt_angle :int= -45
@export var max_tilt_angle :int = 45
@export var flip_power :int = 200
@export var max_velocity :int =200

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta
	#設置傾斜角度
	var tilt_angle = clamp((velocity.y/gravity)*max_tilt_angle, min_tilt_angle, max_tilt_angle)
	self.rotation_degrees = tilt_angle 

	move_and_slide()

func _unhandled_input(event):
	#play_audio()
	if event.is_action_pressed("flap"):
		self.velocity.y = clamp(self.velocity.y-flip_power, max_velocity*-1, max_velocity) #向上的力


#背景音樂
func play_audio():
	audio_stream_player.play()
