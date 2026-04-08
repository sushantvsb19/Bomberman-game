extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $animatedsprite2d
@onready var bombplacementmanager: Bombplacementmanager = $Bombplacementmanager
@onready var raycasts: Raycasts = $raycasts
@onready var speeduptimer: Timer = $Speeduptimer
const speed_multiplier = 2

var max_bombs_at_once = 1                                                                   
var movement: Vector2 = Vector2.ZERO
@export var speed: float = 60.0
var base_speed: float

func _ready() -> void:
	base_speed = speed


func _process(delta: float) -> void:
	var collisions = raycasts.register_collisions()
	if collisions.has(movement):
		return 
	position += movement * delta * speed
	move_and_slide()


func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("right"):
		movement= Vector2.RIGHT
		animated_sprite_2d.play("move_right")
	elif Input.is_action_pressed("left"):
		movement= Vector2.LEFT
		animated_sprite_2d.play("move_left")
	elif Input.is_action_pressed("down"):
		movement = Vector2.DOWN
		animated_sprite_2d.play("move_down")
	elif Input.is_action_pressed("up"):
		movement = Vector2.UP
		animated_sprite_2d.play("move_up")
	elif Input.is_action_pressed("interact"):
		bombplacementmanager.place_bombs()
	else:
		movement = Vector2.ZERO
		animated_sprite_2d.stop()
		
		
func apply_speed_powerup():
	speed = base_speed * speed_multiplier
	animated_sprite_2d.speed_scale = speed_multiplier
	speeduptimer.start()
	
func _on_speeduptimer_timeout() -> void:
	speed = base_speed
	animated_sprite_2d.speed_scale = 1
	
func die():
		animated_sprite_2d.play("die")
		movement = Vector2.ZERO
		set_process_input(false)
		Signalmanager._bomberman_died.emit()


func _on_animatedsprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "die":
		queue_free()
		print("game over")
