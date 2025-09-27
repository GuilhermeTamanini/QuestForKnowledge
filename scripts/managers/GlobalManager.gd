### GlobalManager
### Manager to handle current player data
extends Node

var currentPlayer: Player
var currentEnemyId: String
var playerSprite: CharacterConfig
var currentMap: GameEnums.MapEnum = GameEnums.MapEnum.MAP1
var playerPosisionBeforeLastBattle: Vector2 = Vector2(400, 400)
const DAMAGE: int = 5

func _ready() -> void:
	currentMap = GameEnums.MapEnum.MAP1
