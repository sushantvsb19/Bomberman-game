extends Control

@onready var start_button: MenuButton = $VBoxContainer/StartButton
@onready var exit: MenuButton = $VBoxContainer/Exit


	
	
	



func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
