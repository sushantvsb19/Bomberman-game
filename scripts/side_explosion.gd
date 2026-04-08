extends Area2D
class_name Side_explosions


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



func play_animations(direction_name: String):
	animated_sprite_2d.play(direction_name)
	
	







func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
		





func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
	


func _on_area_entered(area: Area2D) -> void:
	if area is Enemy:
		area.die()
