### Class that contains the Enemy logic
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

func interact() -> void:
	GlobalManager.currentEnemy = self
	GlobalHelper.startCombat()

func takeDamage() -> void:
	health -= GlobalManager.DAMAGE
	if health <= 0:
		push_warning("Health %d" % health)
		die()

func die() -> void:
	if is_instance_valid(self):
		queue_free()

		push_warning(EnemyManager.enemiesData)

		for data in EnemyManager.enemiesData:
			if data.get("node") == self:
				data.erase("node")
				EnemyManager.enemiesData.erase(data)
				break

	GlobalManager.currentEnemy = null
	GlobalHelper.goToWorld()

func _physics_process(delta):
	timer += delta

	if timer >= move_time:
		timer = 0.0
		current_dir_index = (current_dir_index + 1) % directions.size()

	velocity = directions[current_dir_index] * SPEED
	move_and_slide()
