### GlobalManager
### Manager to handle current player data
extends Node

var currentPlayer: Player
var bossCounter: int = 4
var currentEnemyId: String
var playerSprite: CharacterConfig
var currentMap: GameEnums.MapEnum = GameEnums.MapEnum.MAP1
var currentMapVal: int = 0
var playerDefaultPosision: Vector2 = Vector2(400, 400)
var playerPosisionBeforeLastBattle: Vector2 = playerDefaultPosision
var bossKilled: bool = false;
const DAMAGE: int = 5
