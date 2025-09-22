extends CharacterBody2D

class_name IEnemy

var enemyName: String
var dangerLevel: int
var health: int

func interact() -> void:
	GlobalManager.currentEnemy = self
	GlobalHelper.startCombat()

func takeDamage() -> void:
	health -= GlobalManager.DAMAGE
	if health <= 0:
		die()
		GlobalHelper.goToWorld()

func die() -> void:
	if is_instance_valid(self):
		queue_free()

		for data in EnemyManager.enemiesData:
			if data.get("node") == self:
				data.erase("node")
				EnemyManager.enemiesData.erase(data)
				break
