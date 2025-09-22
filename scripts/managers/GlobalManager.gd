### GlobalManager
### Manager to handle current player data
extends Node

var currentPlayer: Player
var playerPosisionBeforeLastBattle: Vector2 = Vector2(400, 400)
var currentEnemy: IEnemy
const DAMAGE: int = 5
