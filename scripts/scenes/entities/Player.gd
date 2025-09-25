### Player.gd. Class that contains the player logic
extends IPlayer

class_name Player

@export var speed: float = 600
var spriteNode: Sprite2D
var vel: Vector2 = Vector2.ZERO
var characterName: String
var sprite: Texture2D
const PLAYER_SIZE: Vector2 = Vector2(64, 64)

func setupFromConfig(config: CharacterConfig):
	characterName = config.name
	health = config.health

	spriteNode = $Sprite2D

	if spriteNode and config.sprite:
		spriteNode.texture = config.sprite
		_normalizeSprite(spriteNode)

func _normalizeSprite(spriteNode: Sprite2D) -> void:
	var textureSize = spriteNode.texture.get_size()
	if textureSize == Vector2.ZERO:
		return

	spriteNode.scale = PLAYER_SIZE / textureSize

	var rectShape = RectangleShape2D.new()
	rectShape.extents = PLAYER_SIZE / 2

	var collision = CollisionShape2D.new()
	collision.shape = rectShape

	add_child(collision)

func _physics_process(delta):
	handle_input()
	velocity = vel
	move_and_slide()

	for i in range(get_slide_collision_count()):
		var col = get_slide_collision(i).get_collider()

		if col is IEnemy:
			col.interact()
			GlobalManager.playerPosisionBeforeLastBattle = global_position

func handle_input():
	vel = Vector2.ZERO
	if Input.is_action_pressed("ui_right"): vel.x += 1
	if Input.is_action_pressed("ui_left"): vel.x -= 1
	if Input.is_action_pressed("ui_down"): vel.y += 1
	if Input.is_action_pressed("ui_up"): vel.y -= 1
	vel = vel.normalized() * speed
