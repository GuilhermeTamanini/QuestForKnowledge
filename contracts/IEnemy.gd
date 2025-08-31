extends IAttackable

class_name IEnemy

var atackPower: int
var sprite: Texture2D

func attack(player: IPlayer) -> void:
	player.character.takeDamage(atackPower)

func interact() -> void:
	PlayerManager.currentEnemy = self
	GlobalHelper.startCombat()
