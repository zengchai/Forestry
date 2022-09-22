extends Node2D


func _ready():
	pass


func _on_Button_pressed():
	$AudioStreamPlayer3.play()
	$Timer.start()
	$AnimationPlayer.play("End")



func _on_Timer_timeout():
	get_tree().change_scene("res://MainMenu.tscn")


func _on_BMenu_mouse_entered():
	$AudioStreamPlayer2.play()
