extends Area2D


class_name powerup




@onready var power_up_setup: powerupsetup = $powerupsetup

var type: HubForPowerups.PowerUptype


@onready var sprite_2d: Sprite2D = $Sprite2D



func init(power_up_resource: powerupresource) -> void:
	sprite_2d.texture = power_up_resource.texture
	type = power_up_resource.type
	
func _on_body_entered(body: Node2D) -> void:
	power_up_setup.activate_powerup(type)
	if body is Player:
		queue_free()
		
