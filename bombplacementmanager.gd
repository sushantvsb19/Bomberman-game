extends Node

class_name Bombplacementmanager

const Bomb_placement_scene = preload("res://Scenes/bomb.tscn")

const Tile_size:int = 16

var player: Player = null
var bombs_placed = 0
var explosion_size = 1

func _ready() -> void:
	player = get_parent()
	
func place_bombs():
	if bombs_placed == player.max_bombs_at_once:
		return
	var bomb = Bomb_placement_scene.instantiate()
	var  player_position = player.global_position
	var bomb_position = Vector2(round(player_position.x / Tile_size)* Tile_size, round(player_position.y / Tile_size) * Tile_size)
	bomb.explosion_size = explosion_size
	bomb.position = bomb_position
	get_tree().root.add_child(bomb)
	bombs_placed += 1
	bomb.tree_exiting.connect(on_bomb_exploded)
func on_bomb_exploded():
	bombs_placed -= 1
	
	
	
	
