### Player.gd. Class that contains the player logic
extends IPlayer

class_name Player

@export var speed: float = 3000
@onready var playerSprite: AnimatedSprite2D = $AnimatedSprite2D
var vel: Vector2 = Vector2.ZERO
var characterName: String
const PLAYER_SIZE: Vector2 = Vector2(4, 4)

func _ready() -> void:
	playerSprite.scale = PLAYER_SIZE

func _physics_process(_delta):
	handle_input()
	velocity = vel
	move_and_slide()

	for i in range(get_slide_collision_count()):
		var col = get_slide_collision(i).get_collider()

		if col is IPortal:
			GlobalManager.playerPosisionBeforeLastBattle = GlobalManager.playerDefaultPosision
			col.interact()

		if col is IEnemy:
			col.interact()
			GlobalManager.playerPosisionBeforeLastBattle = global_position

func handle_input():
	vel = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		playerSprite.play("moveRight")
		vel.x += 1
	elif Input.is_action_pressed("ui_left"):
		playerSprite.play("moveLeft")
		vel.x -= 1
	elif Input.is_action_pressed("ui_down"):
		playerSprite.play("moveDown")
		vel.y += 1
	elif Input.is_action_pressed("ui_up"):
		playerSprite.play("moveUp")
		vel.y -= 1
	else:
		playerSprite.play("idle")

	vel = vel.normalized() * speed
