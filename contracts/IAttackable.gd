extends IInteractable
class_name IAttackable

var health: int
var defense: int = 0

signal died

func takeDamage(amount: int) -> void:
	var damage = max(amount - defense, 0)
	health -= damage
	if health <= 0:
		emit_signal("died")
