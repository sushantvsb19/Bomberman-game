extends Area2D

class_name centerexplosion 

@onready var animated_sprite_center_explosion: AnimatedSprite2D = $AnimatedSprite2D




@onready var raycasts: Array[RayCast2D] = [
	$Raycasts/RayCastUp,
	$Raycasts/RayCastright,
	$Raycasts/RayCastdown,
	$Raycasts/RayCastleft
]

var direction_names = ["top", "right", "bottom", "left"]
var actual_directions: Array[Vector2] = [
	Vector2(0, -tile_area),
	Vector2(tile_area, 0),
	Vector2(0, tile_area),
	Vector2(-tile_area, 0)
]



const side_explosions = preload("res://Scenes/side_explosion.tscn")
const tile_area = 16


var size = 1


func _ready() -> void:
	animated_sprite_center_explosion.play()
	check_raycasts()

func check_raycasts():
	for i in raycasts.size():
		check_raycasts_direction(raycasts[i], direction_names[i], actual_directions[i])
		
func check_raycasts_direction(raycast:RayCast2D, direction_name:String, actual_direction:Vector2):
	raycast.target_position = raycast.target_position * size
	raycast.force_raycast_update()
	if !raycast.is_colliding():
		create_explosion_for_size(size, direction_name, actual_direction)
	else:
		var explosion_size = calculate_explosion_size(raycast)
		var collider = raycast.get_collider()
		if explosion_size != null:
			create_explosion_for_size(size, direction_name, actual_direction)
		execute_explosion_collision(collider)
		

func create_explosion_for_size(explosion_size: int, direction_name: String, animation_position: Vector2):
	for i in explosion_size:
		if i < explosion_size -1:
			create_explosion_animation_slice("%s_middle" % direction_name, animation_position * (i+1))
		else:
			create_explosion_animation_slice("%s_end" % direction_name, animation_position * (i+1))
			
func create_explosion_animation_slice(direction_name: String, animation_position: Vector2):
	print_debug(direction_name)
	var side_explosion = side_explosions.instantiate()
	side_explosion.position = animation_position
	add_child(side_explosion)
	side_explosion.play_animations(direction_name)


func calculate_explosion_size(raycast:RayCast2D):
	var collider = raycast.get_collider()
	if collider is TileSet:
		var collision_point = raycast.get_collision_point()
		var distance_to_collider = raycast.global_position.distance_to(collision_point)
		var explosion_size_before_collider = max(roundi(absf(distance_to_collider)/tile_area-1),0)
		return explosion_size_before_collider
		

	
	
func execute_explosion_collision(collider: Object):
	if collider is brickwall:
		(collider as brickwall).destruction()
		
		






func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()



	


func _on_area_entered(area: Area2D) -> void:
	if area is Enemy:
		area.die()
