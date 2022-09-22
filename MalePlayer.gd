extends KinematicBody2D

var velocity = Vector2(0,0)
var life = 1
var lifex =6
var scores = 0
const SPEED = 200
var direction = 0
const scalehealth = 0.2
var healing = false
signal heals
signal fadeout

func _ready():
	set_modulate(Color(1,1,1,1))
	$right.monitoring = false
	$left.monitoring = false
	
func _physics_process(_delta):
	if $Health/blue.scale.x >= 0.0645:
		if Input.is_action_pressed("Attack"):
			$Health/blue.scale.x -= 3.65*0.01
			$Health/blue.position.x -= 240*(0.0046)
			
			if direction == 2:
				$Attack.play()
				$SwordMotion.play("upright")
				$right.monitoring = true
				Input.action_release("ui_right")
			elif direction == 4:
				$Attack.play()
				$SwordMotion.play("upleft")
				$left.monitoring = true
				Input.action_release("ui_left")
			else:
				$SwordMotion.play("idle")
		else:
			$SwordMotion.play("idle")
			$right.monitoring = false
			$left.monitoring = false
			if $Health/blue.scale.x != 3.65 and $Health/blue.position.x !=240:
				$Health/blue.scale.x += 3.65*0.01
				$Health/blue.position.x += 240*(0.0046)
	else:
		$SwordMotion.play("idle")
		$right.monitoring = false
		$left.monitoring = false
		if $Health/blue.scale.x != 3.65 and $Health/blue.position.x !=240:
			$Health/blue.scale.x += 3.65*0.01
			$Health/blue.position.x += 240*(0.0046)
	
	if Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		velocity.y = SPEED
		$Motion.play("downright")
		$SwordMotion.play("idle")
	elif Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		velocity.y = SPEED
		$Motion.play("downleft")
		$SwordMotion.play("idle")
	elif Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		velocity.y = -SPEED
		$Motion.play("upleft")
		$SwordMotion.play("idle")
	elif Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		velocity.y = -SPEED
		$Motion.play("upright")
		$SwordMotion.play("idle")
	elif Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
		direction=3
		$Motion.play("down")
		$SwordMotion.play("idle")
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
		direction=1
		$Motion.play("Up")
		$SwordMotion.play("idle")
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		direction=2
		$Motion.play("right")
		$SwordMotion.play("idle")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		direction=4
		$Motion.play("left")
		$SwordMotion.play("idle")
	else:
		if direction==2:
			if Input.is_action_pressed("Attack"):
				if $Health/blue.scale.x>0.0645:
					$Motion.play("AttackUpRight")
				else:
					Input.action_release("Attack")
			else:
				$Motion.play("rightidle")
		if direction==1:
			$Motion.play("upidle")
		if direction==3:
			$Motion.play("idledown")
		if direction==4:
			if Input.is_action_pressed("Attack"):
				if $Health/blue.scale.x>0.0645:
					$Motion.play("AttackUpLeft")
				else:
					Input.action_release("Attack")
			else:
				$Motion.play("leftidle")
	
	velocity = move_and_slide(velocity)
	velocity.x = lerp(velocity.x,0,1)
	velocity.y = lerp(velocity.y,0,1)
	$Health/Score.text = String(scores)		
	
func ouch(var posx,var posy):
	
	$Health/red.scale.x = 3.65-3.65*scalehealth*life
	$Health/red.position.x = 240-240*(scalehealth/2)*life+2*life
	life += 1
	lifex -= 1
	$Hurt.play()
	if posx == 0:
		if position.y < posy:
			velocity.y = -5000
		elif position.y > posy:
			velocity.y = 5000
	elif posy == 0:
		print (position.x)
		print (posx)
		if position.x < posx+200:
			velocity.x = -5000
		elif position.x > posx+200:
			velocity.x = 5000
		
	Input.action_release("ui_up")
	Input.action_release("ui_down")
	Input.action_release("ui_right")
	Input.action_release("ui_left")
	set_collision_layer_bit(0,false)
	set_collision_mask_bit(3,false)
	if life==6:
		emit_signal("fadeout")
		$AnimationPlayer.play("Die")
		$fadeout.start()
	else:
		$HurtTimer.start()
		$AnimationPlayer.play("Hurt")
	


func _on_HurtTimer_timeout():
	set_modulate(Color(1,1,1,1))
	set_collision_layer_bit(0,true)
	set_collision_mask_bit(3,true)


func _on_left_body_entered(body):
	if direction == 2 or direction == 4:
		if body.get_collision_layer() == 8:
			scores +=1
			body.die()

func _on_right_body_entered(body):
	if direction == 2 or direction == 4:
		if body.get_collision_layer() == 8:
			scores +=1
			body.die()


func _on_HealTimer_timeout():
	if healing:
		$Health/red.scale.x = 0+3.65*scalehealth*lifex
		$Health/red.position.x = 130+240*(scalehealth/2)*lifex-2*lifex
		life -= 1
		lifex += 1
		healing = false


func _on_Level1Map_heal():
	if Input.is_action_pressed("heal") and lifex<6:
		healing = true
		$HealTimer.start()
		emit_signal("heals")
		Input.action_release("heal")



func _on_fadeout_timeout():
	get_tree().change_scene("res://GameOver.tscn")
