extends Node2D


func _ready():
	pass


func _on_NextSceen_body_entered(body):
	if body.name=="MalePlayer":
		$Timer.start()
		$AnimationPlayer.play("NextSceen")


func _on_Timer_timeout():
	get_tree().change_scene("res://Animation2.tscn")


