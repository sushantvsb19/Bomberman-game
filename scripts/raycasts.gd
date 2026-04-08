extends Node2D

class_name Raycasts 




@onready var raycast_horizontal_left: Array[RayCast2D] = [
	$Horizontal/Left/lefthorizontalbottom,
	$Horizontal/Left/lefthorizontaltop
]
@onready var raycast_horizontal_right: Array[RayCast2D] = [
	$Horizontal/right/righthorizontalbottom,
	$Horizontal/right/righthorizontaltop
]

@onready var raycast_vertical_up: Array[RayCast2D] = [
	$Vertical/up/upverticalright,
	$Vertical/up/upverticalleft
]

@onready var raycast_vertical_down: Array[RayCast2D] =[
	$Vertical/down/downverticalright,
	$Vertical/down/downverticalleft
]


func register_collisions() -> Array[Vector2]:
	var collisions: Array[Vector2] = []
	
	var is_left_colliding = raycast_horizontal_left.reduce(_is_raycast_colliding, false)
	if is_left_colliding:
		collisions.append(Vector2.LEFT)
	
	var is_right_colliding = raycast_horizontal_right.reduce(_is_raycast_colliding, false)
	if is_right_colliding:
		collisions.append(Vector2.RIGHT)
	
	var is_up_colliding = raycast_vertical_up.reduce(_is_raycast_colliding, false)
	if is_up_colliding:
		collisions.append(Vector2.UP)
	
	var is_down_colliding = raycast_vertical_down.reduce(_is_raycast_colliding, false)
	if is_down_colliding:
		collisions.append(Vector2.DOWN)
	
	
	return collisions
	
func _is_raycast_colliding(acc: bool, next: RayCast2D):
	return next.is_colliding() || acc
