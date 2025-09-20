extends CharacterBody2D
class_name Enemy

var enemyName: String
var dangerLevel: int
var inventory: Array = []
var enemy: IEnemy

@onready var sprite_node: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func setup_from_config(config: EnemyConfig):
	enemyName = config.name
	dangerLevel = config.dangerLevel
	inventory = []

	enemy.attackPower = config.attackPower
	enemy.health = config.health

	if sprite_node and config.sprite:
		sprite_node.texture = config.sprite

	# ajusta o CollisionShape2D de acordo com o sprite
	if collision and sprite_node.texture:
		var objShape = RectangleShape2D.new()
		objShape.extents = sprite_node.texture.get_size() * sprite_node.scale / 2
		collision.shape = objShape

func interact() -> void:
	print("Player encontrou %s (nível %d)" % [enemyName, dangerLevel])
	PlayerManager.currentEnemy = self
	GlobalHelper.startCombat()
