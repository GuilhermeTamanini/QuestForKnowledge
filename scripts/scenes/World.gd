### World.gd
extends Node2D

@onready var map: Sprite2D = $Map
@onready var pauseMenu: Control = $PauseLayer/PauseMenu
@onready var continueButton: Button = $PauseLayer/PauseMenu/CenterContainer/VBoxContainer/ContinueButton
@onready var quitButton: Button = $PauseLayer/PauseMenu/CenterContainer/VBoxContainer/QuitButton

func _ready() -> void:
	pauseMenu.visible = false
	pauseMenu.process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	continueButton.process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	quitButton.process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	continueButton.pressed.connect(_onContinuePressed)
	quitButton.pressed.connect(_onQuitPressed)

	# Criação do mapa e player
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

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_togglePause()

func _togglePause():
	if get_tree().paused:
		get_tree().paused = false
	else:
		get_tree().paused = true
	pauseMenu.visible = get_tree().paused

func _onContinuePressed():
	get_tree().paused = false
	pauseMenu.visible = false

func _onQuitPressed():
	get_tree().quit()

func makeWall(position: Vector2, size: Vector2) -> StaticBody2D:
	var wall = StaticBody2D.new()
	var shape = RectangleShape2D.new()
	shape.size = size
	var collision = CollisionShape2D.new()
	collision.shape = shape
	wall.add_child(collision)
	wall.position = position
	return wall

func createMapBorders():
	var map_size = Vector2(640, 480)
	var scale = Vector2(8.953, 6.002)
	var scaled_size = map_size * scale
	var thickness = 20

	add_child(makeWall(Vector2(scaled_size.x/2, -thickness/2), Vector2(scaled_size.x, thickness))) # Superior
	add_child(makeWall(Vector2(scaled_size.x/2, scaled_size.y + thickness/2), Vector2(scaled_size.x, thickness))) # Inferior
	add_child(makeWall(Vector2(-thickness/2, scaled_size.y/2), Vector2(thickness, scaled_size.y))) # Esquerda
	add_child(makeWall(Vector2(scaled_size.x + thickness/2, scaled_size.y/2) + Vector2(15, 15), Vector2(thickness, scaled_size.y))) # Direita

func setCameraLimits(camera: Camera2D) -> void:
	var map_size = map.texture.get_size() * map.scale
	var margin = 32
	camera.limit_left = -800
	camera.limit_top = 80
	camera.limit_right = 4935
	camera.limit_bottom = 2960
