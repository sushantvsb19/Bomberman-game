extends Node

class_name powerupsetup

var player: Player
var animatedsprite_2d: AnimatedSprite2D
var bomb_placement_manager: Bombplacementmanager 
var speed_up_timer: Timer 
var raycasts: Raycasts
var raycast_nodes: Array



func _ready() -> void:
	player = get_tree().get_first_node_in_group("players")
	raycast_nodes = get_tree().get_nodes_in_group("raycasts")
	if is_instance_valid(player):
		animatedsprite_2d = player.get_node("animatedsprite2d")
		bomb_placement_manager = player.get_node("Bombplacementmanager")
		raycasts = player.get_node("raycasts")
		
		
		
	
		
	
func activate_powerup(power_up_type: HubForPowerups.PowerUptype):
	if player:
		match power_up_type:
			HubForPowerups.PowerUptype.Power_Up_Bomb:
				player.max_bombs_at_once += 1
			HubForPowerups.PowerUptype.Power_Up_Fire:
				bomb_placement_manager.explosion_size += 1
			HubForPowerups.PowerUptype.Power_Up_Speed:
				player.apply_speed_powerup()
			HubForPowerups.PowerUptype.Power_Up_Wallpass:
				for raycasts in raycast_nodes:
					raycasts.set_collision_mask_value(3,false)
				
				
				

				
		
