extends CollisionShape2D

@onready var sprite_node: Sprite2D = get_parent().get_node("Sprite2D")

func _ready():
	if sprite_node and sprite_node.texture:
		var objShape = RectangleShape2D.new()
		objShape.extents = sprite_node.texture.get_size() * sprite_node.scale
		shape = objShape
