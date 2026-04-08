extends Area2D

class_name brickwall

@onready var animatedsprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const POWERUP = preload("res://Scenes/powerup.tscn")
const DOOR = preload("res://Scenes/door.tscn")

@export var power_up_resource: powerupresource
@export var door_transition_resource: Doortransitionresource

func destruction() -> void:
	animatedsprite_2d.play("Destruction")
	
	

	



func _on_animated_sprite_2d_animation_finished() -> void:
	if  animatedsprite_2d.animation == "Destruction":
		if power_up_resource != null:
			spawn_power_up()
		if door_transition_resource != null:
			spawn_door()
		queue_free()

func spawn_power_up():
	var power_up = POWERUP.instantiate()
	power_up.global_position = global_position
	get_tree().root.add_child(power_up)
	power_up.init(power_up_resource)
	
	
func spawn_door():
	var door_transition = DOOR.instantiate()
	door_transition.global_position = global_position
	get_tree().root.add_child(door_transition)
	door_transition.init(door_transition_resource)
