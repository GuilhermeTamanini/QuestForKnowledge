### Resource to make new enemies creations simple
### Example: res://enemies/Slime.tres
extends Resource

class_name EnemyConfig

@export var name: String
@export var dangerLevel: GameEnums.DangerLevel
@export var health: int
@export var sprite: Texture2D
