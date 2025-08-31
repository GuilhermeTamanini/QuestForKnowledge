extends CollisionShape2D

@onready var collision = $CollisionShape2D

func _ready():
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(32, 16)
	collision.shape = shape
