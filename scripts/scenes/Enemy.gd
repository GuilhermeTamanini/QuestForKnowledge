extends IEnemyCollidable
class_name Enemy

@onready var collision: CollisionShape2D = $CollisionShape2D
const SPEED := 150.0
const RADIUS := 20.0
const COLOR := Color(1.0, 0.2, 0.2)

var directions = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
var current_dir_index = 0
var move_time = 1.5
var timer = 0.0

func setupFromConfig(config: EnemyConfig):
	enemyName = config.name
	dangerLevel = config.dangerLevel

	var stats = IEnemy.new()
	stats.attackPower = config.attackPower
	stats.health = config.health
	enemy = stats
	var sprite_node = Sprite2D.new()

	if sprite_node and config.sprite:
		sprite_node.texture = config.sprite

	add_child(sprite_node)

func interact() -> void:
	print("Player encontrou %s (nível %d)" % [enemyName, dangerLevel])
	GlobalManager.currentEnemy = self
	GlobalHelper.startCombat()

func _physics_process(delta):
	timer += delta

	if timer >= move_time:
		timer = 0.0
		current_dir_index = (current_dir_index + 1) % directions.size()

	velocity = directions[current_dir_index] * SPEED
	move_and_slide()
