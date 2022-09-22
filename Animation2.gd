extends Node2D


func _ready():
	$Timer.start()
	$BPlayAgain.disabled = true
	

func _on_Timer_timeout():
	$Pressbutton.play("PressButton")
	$BPlayAgain.disabled = false
	


func _on_BPlayAgain_pressed():
	$AudioStreamPlayer3.play()
	get_tree().change_scene("res://MainMenu.tscn")


func _on_BPlayAgain_mouse_entered():
	$AudioStreamPlayer2.play()
