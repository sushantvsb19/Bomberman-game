extends Area2D

class_name Bomb
const center_explosion = preload("res://Scenes/centerexplosion.tscn") #preload the scene of the explosion 

var explosion_size = 1



func _on_timer_timeout() -> void: #created a timer for the explosion of the bomb 
	var explosion = center_explosion.instantiate() #instantiate the scene of explosion
	explosion.position = position
	explosion.size = explosion_size
	get_tree().root.add_child(explosion)
	queue_free()
