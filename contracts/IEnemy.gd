extends IAttackable

class_name IEnemy

var attackPower: int

func attack(player: IPlayer) -> void:
	player.character.takeDamage(attackPower)
