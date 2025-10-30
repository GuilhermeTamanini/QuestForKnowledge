### GlobalManager
### Manager to handle current general data
extends Node

var currentPlayer: Player
var bossCounter: int = 4
var currentEnemyId: String
var currentMap: GameEnums.MapEnum = GameEnums.MapEnum.MAP1
var currentMapVal: int = 0
var playerDefaultPosision: Vector2 = Vector2(400, 400)
var playerPosisionBeforeLastBattle: Vector2 = playerDefaultPosision
var bossKilled: bool = false;
const DAMAGE: int = 5
# Todas as perguntas, deve ser armazenada de forma imútavel para poder redefinir as perguntas ao resetar o jogo
const defaultQuestions: Dictionary = {}
# As perguntas numa variável mutável para poder ser manipulada para remover questões já vista pelo usuário
var gameQuestions: Dictionary = defaultQuestions
