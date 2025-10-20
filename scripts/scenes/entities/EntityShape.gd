extends CollisionShape2D

@onready var animatedSprite2D: AnimatedSprite2D = get_parent().get_node("PortalSprite")

func _ready():
	var objShape = RectangleShape2D.new()
	objShape.extents = Vector2(32, 32)
	shape = objShape
