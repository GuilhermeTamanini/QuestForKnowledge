extends IAttackable

class_name ICharacter

var attackPower: int

func attack(target: IEnemy) -> void:
	target.takeDamage(attackPower)
