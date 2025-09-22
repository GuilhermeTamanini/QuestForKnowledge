extends CharacterBody2D

class_name IPlayer

var health: int

func takeDamage() -> void:
	health -= GlobalManager.DAMAGE

	if health <= 0:
		GlobalHelper.gameOver()
