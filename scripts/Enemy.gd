extends CharacterBody2D
class_name Enemy

var enemyName: String
var dangerLevel: int
var enemy: IEnemy
var inventory: Array = []

@onready var sprite_node: Sprite2D = $Sprite

func setup_from_config(config: EnemyConfig):
	enemyName = config.name
	dangerLevel = config.dangerLevel
	inventory = []
	
	enemy = IEnemy.new()
	enemy.health = config.health
	enemy.atackPower = config.attackPower
	
	if config.sprite:
		sprite_node.texture = config.sprite

func interact() -> void:
	print("Player encontrou %s (nível %d)" % [enemyName, dangerLevel])
	PlayerManager.currentEnemy = self.enemy
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.COMBAT)
