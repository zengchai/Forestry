extends Node2D


func _ready():
	$Timer.start()
	$AnimationPlayer.play("Visible")
	

func _on_Timer_timeout():
	get_tree().change_scene("res://MainMenu.tscn")
	
