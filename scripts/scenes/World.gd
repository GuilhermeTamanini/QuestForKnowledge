### World.gd
extends Node2D

@onready var map: Sprite2D = $Map
@onready var pauseMenu: Control = $PauseLayer/PauseMenu
@onready var continueButton: Button = $PauseLayer/PauseMenu/CenterContainer/VBoxContainer/ContinueButton
@onready var quitButton: Button = $PauseLayer/PauseMenu/CenterContainer/VBoxContainer/QuitButton

func _ready() -> void:
	if GlobalManager.bossKilled:
		var portalNode: Resource = load("res://scenes/entities/portalscene.tscn")
		add_child(portalNode.instantiate())

	map.texture = load(GlobalHelper.getCurrentMapSprite());

	createMapBorders()
	var playerScene = load("res://scenes/entities/player.tscn")
	var player: IPlayer = playerScene.instantiate()
	var characterCfg: CharacterConfig = load("res://characters/Test.tres")
	player.setupFromConfig(characterCfg)
	add_child(player)
	player.global_position = GlobalManager.playerPosisionBeforeLastBattle

	GlobalManager.playerSprite = characterCfg
	GlobalManager.currentPlayer = player

	# without player position it doesn't appears - need fix
	pauseMenu.position = GlobalManager.currentPlayer.global_position

	var camera = Camera2D.new()
	player.add_child(camera)
	camera.position = Vector2.ZERO
	camera.make_current()
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 5.0
	camera.zoom = Vector2(0.5, 0.5)
	setCameraLimits(camera)

	EnemyManager.instantiateEnemies(self)

	MusicManager.playMusic(GameEnums.MusicEnum.OVERWORLD)

func makeWall(pos: Vector2, size: Vector2) -> StaticBody2D:
	var wall = StaticBody2D.new()
	var shape = RectangleShape2D.new()
	shape.size = size
	var collision = CollisionShape2D.new()
	collision.shape = shape
	wall.add_child(collision)
	wall.position = pos
	return wall

func createMapBorders():
	var mapSize = Vector2(640, 480)
	var mapScale = Vector2(8.953, 6.002)
	var scaledSize = mapSize * mapScale
	var thickness = 20

	add_child(makeWall(Vector2(scaledSize.x / 2, -thickness / 2), Vector2(scaledSize.x, thickness))) # Up
	add_child(makeWall(Vector2(scaledSize.x / 2, scaledSize.y + thickness / 2), Vector2(scaledSize.x, thickness))) # Down
	add_child(makeWall(Vector2(-thickness / 2, scaledSize.y / 2), Vector2(thickness, scaledSize.y))) # Left
	add_child(makeWall(Vector2(scaledSize.x + thickness / 2, scaledSize.y / 2) + Vector2(15, 15), Vector2(thickness, scaledSize.y))) # Right

func setCameraLimits(camera: Camera2D) -> void:
	camera.limit_left = -800
	camera.limit_top = 80
	camera.limit_right = 4935
	camera.limit_bottom = 2960
