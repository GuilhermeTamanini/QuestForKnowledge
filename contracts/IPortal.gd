# PortalBody.gd
extends CharacterBody2D

class_name IPortal

func _ready():
	$PortalSprite.scale = Vector2(4, 4)
	global_position = Vector2(600, 600)
	$PortalSprite.play("idle")
	$PortalSprite.z_index = 10

	var objShape = RectangleShape2D.new()
	objShape.extents = Vector2(64, 64)
	$CollisionShape2D.shape = objShape

func interact() -> void:
	GlobalHelper.setCurrentMap()
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.WORLD)
