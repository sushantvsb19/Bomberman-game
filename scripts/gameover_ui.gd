extends Control


@onready var restart: Button = $VBoxContainer/Restart
@onready var back_to_main_menu: Button = $"VBoxContainer/Back to main menu"
@onready var quit: Button = $VBoxContainer/Quit



func _ready() -> void:
	hide()
	Signalmanager._bomberman_died.connect(_bomberman_signal)



func _bomberman_signal():
	show()






func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_back_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
