extends Area2D

class_name Enemy

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: float = 20.0
@export var chance_of_direction_change: float = 0.5
@export var direction_change_timeout: float = 3.0
@export var direction_current_change_timeout: float = 0

var direction: Vector2 = Vector2.LEFT
var tile_map: TileMapLayer



func _ready() -> void:
	tile_map = get_tree().get_first_node_in_group("tilemaps")

	

func snap_to_x():
	position.x = roundf(position.x / 16) * 16
	
func snap_to_y():
	position.y = roundf(position.y / 16) * 16
	
	
func _process(delta: float) -> void:
	position += direction * speed * delta
	
	
	if direction == Vector2.LEFT or direction == Vector2.RIGHT:
		snap_to_y()
	if direction == Vector2.UP or direction == Vector2.DOWN:
		snap_to_x()
		
	if roundi(position.x) % 16 == 0 && roundi(position.y) % 16 == 0 && \
		direction_current_change_timeout >= direction_change_timeout && \
		randf() <= chance_of_direction_change:
			direction_current_change_timeout = 0
			changing_direction_at_intersection(direction)
			
	direction_current_change_timeout += delta
			
			
func changing_direction_at_intersection(current_direction: Vector2):
	direction = calculate_newdirections(current_direction, true)
	
	
	
func calculate_newdirections(current_direction: Vector2, prevent_backtracking: bool) -> Vector2:
	var all_directions = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
	var all_possible_directions: Array[Vector2] = []
	
	
	#preventing from continuing to the current direction and backtracking to the opposite direction 
	all_directions.erase(current_direction)
	if prevent_backtracking:
		all_directions.erase(-current_direction) 
	
	#checking if the direction is not blocked by the tileset and then selecting the direction 
	for check_directions in all_directions:
		if not direction_is_blocked(check_directions):
			all_possible_directions.append(check_directions)
			
	#check all the possible direcitons in the array index of directions and then change in the possible directions 
	if all_possible_directions.size() > 0:
		var new_direction = all_possible_directions[randi_range(0, all_possible_directions.size())-1]
		change_enemy_direction(new_direction)
		return new_direction
	return current_direction
			
			
			
			
			
#check if there is  direction blockage due to the tilemap 
func direction_is_blocked(check_directions: Vector2):
	var check_position = round(position / 16)*16 + check_directions * 16
	var check_local_position = tile_map.to_local(check_position)
	var tile_position = tile_map.local_to_map(check_local_position)
	var tile_data = tile_map.get_cell_tile_data(tile_position)
	return tile_data != null
	
	
	
	

	
	
	
	
	
func change_enemy_direction(new_direction: Vector2):
	if [Vector2.LEFT, Vector2.RIGHT].has(new_direction):
		animated_sprite_2d.scale.x = sign(new_direction.x)
	
	
	
	
	
		
	
		
	
	
func die():
	animated_sprite_2d.play("death")
	set_physics_process(false)
	speed = 0
	direction = Vector2.ZERO
	set_collision_mask_value(1,false)
	
	
	
		
	
		
		
		
		
	


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		(body as Player).die()
	if body is TileMapLayer:
		direction = calculate_newdirections(direction, false)
	
		

	




func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "death":
		queue_free()





func _on_area_entered(area: Area2D) -> void:
	direction = calculate_newdirections(direction,false)
