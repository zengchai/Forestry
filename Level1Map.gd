extends Node2D

signal heal
export var switch = false

func _ready():
	$AnimatedSprite.play("idle")
	pass


func _on_Area2D_body_exited(body):
	if body.name=="MalePlayer":
		switch = false


func _on_Area2D_body_entered(body):
	if body.name=="MalePlayer":
		switch = true
	
func _physics_process(delta):
	if switch:
		emit_signal("heal")

func _on_MalePlayer_heals():
	$AnimatedSprite.play("heal")
	$Timer.start()
	$TimerAudio.start()


func _on_Timer_timeout():
	$AnimatedSprite.play("idle")


func _on_MalePlayer_fadeout():
	$AnimationPlayer.play("End")


func _on_TimerAudio_timeout():
	$AudioStreamPlayer.play()
