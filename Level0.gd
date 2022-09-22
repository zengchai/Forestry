extends Node2D


func _ready():
	$AnimationPlayer.play("Start")

"res://assets/wav-short-loopable-background-music/wav-short-loopable-background-music/Spinning out.wav"
func _on_NextSceen_body_entered(body):
	if body.name=="MalePlayer":
		$Timer.start()
		$AnimationPlayer.play("NextSceen")



func _on_Timer_timeout():
	get_tree().change_scene("res://Level1.tscn")
