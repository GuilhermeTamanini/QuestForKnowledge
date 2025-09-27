### Enemy.gd. Class that contains the Enemy logic
extends IEnemy

class_name Enemy

const SPEED := 150

var id: String
var directions = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
var current_dir_index = 0
var move_time = 1.5
var timer = 0
const MOB_SIZE = Vector2(100, 100)
const BOSS_SIZE = Vector2(256, 256)
var isBoss := false

func setupFromConfig(config: EnemyConfig):
	enemyName = config.name
	dangerLevel = config.dangerLevel
	isBoss = config.dangerLevel == GameEnums.DangerLevel.BOSS

	health = config.health

	var spriteNode = Sprite2D.new()
	spriteNode.texture = config.sprite
	_normalizeSprite(spriteNode)
	add_child(spriteNode)

func _normalizeSprite(sprite: Sprite2D) -> void:
	var textureSize = sprite.texture.get_size()
	if textureSize == Vector2.ZERO:
		return

	var targetSize = BOSS_SIZE if isBoss else MOB_SIZE
	sprite.scale = targetSize / textureSize

	var rectShape = RectangleShape2D.new()
	rectShape.extents = targetSize / 2

	var collision = CollisionShape2D.new()
	collision.shape = rectShape

	add_child(collision)

func pushPlayerAway():
	var player = GlobalManager.currentPlayer
	if player:
		var dir = (player.global_position - global_position).normalized()
		player.global_position += dir * 64

func showBossWarning():
	var lbl := Label.new()
	lbl.position = GlobalManager.currentPlayer.global_position + Vector2(0, -50)
	lbl.text = "Mate todos os mobs primeiro!"
	lbl.add_theme_color_override("font_color", Color(1, 0, 0))
	lbl.add_theme_font_size_override("font_size", 32)
	lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	lbl.anchor_left = 0.25
	lbl.anchor_top = 0.45
	lbl.anchor_right = 0.75
	lbl.anchor_bottom = 0.55

	get_tree().current_scene.add_child(lbl)

	await get_tree().create_timer(2.0).timeout
	lbl.queue_free()

func pauseGameForWarning():
	get_tree().paused = true
	showBossWarning()
	await get_tree().create_timer(2.0).timeout
	get_tree().paused = false

func interact() -> void:
	if isBoss and not EnemyManager.canChallengeBoss():
		pushPlayerAway()
		await pauseGameForWarning()
		return

	GlobalManager.currentEnemyId = id
	GlobalHelper.startCombat()

#func _physics_process(delta):
	#if isBoss: return
	#timer += delta
#
	#if timer >= move_time:
		#timer = 0.0
		#current_dir_index = (current_dir_index + 1) % directions.size()
#
	#velocity = directions[current_dir_index] * SPEED
	#move_and_slide()
