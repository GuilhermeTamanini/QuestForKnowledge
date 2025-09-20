extends Control

var player: Player
var enemy: Enemy

@onready var playerSprite: Sprite2D = $PlayerSprite
@onready var enemySprite: Sprite2D = $EnemySprite
var questions = []
var current_question = {}
var buttons = []

func _ready() -> void:
	player = PlayerManager.currentPlayer
	enemy = PlayerManager.currentEnemy

	playerSprite.texture = player.sprite
	playerSprite.position = Vector2(200, 200)
	enemySprite.position = Vector2(600, 200)

	loadQuestions()

	for i in range(4):
		var button = get_node("Opcoes/Opção%d" % (i + 1))
		buttons.append(button)

		var idx = i
		button.pressed.connect(func(): checkAnswer(idx))

	newQuestion()
	updateHud()

func loadQuestions() -> void:
	var file: FileAccess = FileAccess.open("res://data/questions.json", FileAccess.READ)
	
	if not file:
		return

	var allQuestions: Array = JSON.parse_string(file.get_as_text())
	
	file.close()

	# TODO Enemy has a config called dangerLevel, this will help when we need to change the level of the questions. 
	for question in allQuestions:
		if question.get("difficultyLevel", 1) == 1:
			questions.append(question)

func newQuestion() -> void:
	if questions.is_empty():
		$QuestionLabel.text = "Sem questões carregadas."
		return
	
	current_question = questions[randi() % questions.size()]
	$QuestionLabel.text = current_question["question"]

	for i in range(4):
		buttons[i].text = current_question["options"][i]

func checkAnswer(index: int) -> void:
	if index == current_question["correct"]:
		enemy.takeDamage(player.character.attackPower)
		$Feedback.text = "Resposta correta!"
	else:
		player.character.takeDamage(enemy.attackPower)
		$Feedback.text = "Resposta errada!"

	updateHud()

	if enemy.health <= 0:
		$Feedback.text = "Você venceu!"
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scenes/world.tscn")

	elif player.character.health <= 0:
		$Feedback.text = "Você perdeu!"
		await get_tree().create_timer(2).timeout
		GlobalHelper.gameOver()
	else:
		newQuestion()

func updateHud() -> void:
	$PlayerLife.text = "Vida Jogador: %d" % player.character.health
	$EnemyLife.text = "Vida Inimigo: %d" % enemy.health
