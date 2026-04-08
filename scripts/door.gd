extends Area2D

class_name Door 

@onready var sprite_2d: Sprite2D = $Sprite2D


var door_type: HubForPowerups.door_transition





func init(door_transition_resource: Doortransitionresource) -> void:
	sprite_2d.texture = door_transition_resource.door_texture
	door_type = door_transition_resource.door_transition
	
	
	


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().change_scene_to_file("res://Scenes/Level_2.tscn")
		queue_free()
