extends Node2D


func _ready():
	pass



func _on_BPlay_pressed():
	$AudioStreamPlayer3.play()
	get_tree().change_scene("res://Level0.tscn")


func _on_BPlay_mouse_entered():
	$AudioStreamPlayer2.play()
	
