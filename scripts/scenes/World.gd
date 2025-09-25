### World.gd
extends Node2D

func _ready() -> void:
	createMapBorders()
	var player_scene = load("res://scenes/entities/player.tscn")
	var player: IPlayer = player_scene.instantiate()
	var characterCfg: CharacterConfig = load("res://characters/Test.tres")
	player.setupFromConfig(characterCfg)
	add_child(player)
	player.global_position = GlobalManager.playerPosisionBeforeLastBattle

	GlobalManager.playerSprite = characterCfg
	GlobalManager.currentPlayer = player

	var camera = Camera2D.new()
	player.add_child(camera)
	camera.position = Vector2.ZERO
	camera.make_current()
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 5.0
	camera.zoom = Vector2(0.5, 0.5)

	EnemyManager.instantiateEnemies(self)

func make_wall(position: Vector2, size: Vector2) -> StaticBody2D:
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

	add_child(make_wall(Vector2(scaled_size.x/2, -thickness/2), Vector2(scaled_size.x, thickness))) # Superior
	add_child(make_wall(Vector2(scaled_size.x/2, scaled_size.y + thickness/2), Vector2(scaled_size.x, thickness))) # Inferior
	add_child(make_wall(Vector2(-thickness/2, scaled_size.y/2), Vector2(thickness, scaled_size.y))) # Esquerda
	add_child(make_wall(Vector2(scaled_size.x + thickness/2, scaled_size.y/2), Vector2(thickness, scaled_size.y))) # Direita
