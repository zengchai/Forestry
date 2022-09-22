extends KinematicBody2D
var turn = 0
var turnback = 0
export var f = false

func _ready():
	if f:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false

func _physics_process(delta):
	if !f:
		if $AnimatedSprite.flip_h:
			position.x +=2
			turn -=1
		else:
			position.x -= 2
			turn += 1
			
		if turn == 100:
			$AnimatedSprite.flip_h = true
		elif turn == 0:
			$AnimatedSprite.flip_h = false
	else:
		if $AnimatedSprite.flip_h:
			position.x +=2
			turn +=1
		else:
			position.x -= 2
			turn -= 1
			
		if turn == 0:
			$AnimatedSprite.flip_h = true
		elif turn == 100:
			$AnimatedSprite.flip_h = false
		

func _on_upanddown_body_entered(body):
	if body.name == "MalePlayer":
		body.ouch(0,position.y)

func _on_leftandright_body_entered(body):
	if body.name == "MalePlayer":
		body.ouch(position.x,0)

func die():
	$AudioStreamPlayer.play()
	$Timer.start()

func _on_MalePlayer_fadeout():
	$AnimationPlayer.play("Ends")


func _on_Timer_timeout():
	queue_free()
