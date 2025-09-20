extends IAttackable

class_name IEnemy

var attackPower: int
var sprite: Texture2D

func attack(player: IPlayer) -> void:
	player.character.takeDamage(attackPower)
