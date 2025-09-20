extends IPlayer
class_name Player

@export var speed: float = 200
@onready var spriteNode: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
var vel: Vector2 = Vector2.ZERO
var characterName: String
var sprite: Texture2D

func setupFromConfig(config: CharacterConfig):
	characterName = config.name
	character = ICharacter.new()
	character.health = config.health
	character.attackPower = config.attackPower
	
	if spriteNode and config.sprite:
		sprite = config.sprite
		spriteNode.texture = config.sprite

func _physics_process(delta):
	handle_input()
	velocity = vel
	move_and_slide()

	for i in range(get_slide_collision_count()):
		var col = get_slide_collision(i).get_collider()

		if col is CharacterBody2D:
			col.interact()

func handle_input():
	vel = Vector2.ZERO
	if Input.is_action_pressed("ui_right"): vel.x += 1
	if Input.is_action_pressed("ui_left"): vel.x -= 1
	if Input.is_action_pressed("ui_down"): vel.y += 1
	if Input.is_action_pressed("ui_up"): vel.y -= 1
	vel = vel.normalized() * speed
