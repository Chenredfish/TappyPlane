extends CharacterBody2D


const SPEED = -300.0

signal rock_entered

func _physics_process(delta):
	self.velocity.x =SPEED
	move_and_slide()
	if self.position.x <= -56:
		self.queue_free()

func _on_area_2d_body_entered(body):
	#if body.is_in_group(""): 檢測在組別裡面
	rock_entered.emit()
