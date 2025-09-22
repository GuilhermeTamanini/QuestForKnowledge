extends IEnemy

class_name Enemy

@onready var collision: CollisionShape2D = $CollisionShape2D
const SPEED := 150

var directions = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
var current_dir_index = 0
var move_time = 1.5
var timer = 0

func setupFromConfig(config: EnemyConfig):
	enemyName = config.name
	dangerLevel = config.dangerLevel

	health = config.health

	var sprite_node = Sprite2D.new()
	sprite_node.texture = config.sprite
	sprite_node.scale = Vector2(0.3, 0.3)
	add_child(sprite_node)

func _physics_process(delta):
	timer += delta

	if timer >= move_time:
		timer = 0.0
		current_dir_index = (current_dir_index + 1) % directions.size()

	velocity = directions[current_dir_index] * SPEED
	move_and_slide()
