extends Control

var player: IPlayer
var enemy: IEnemy

var questions = []
var current_question = {}
var buttons = []

func _ready():
	player = PlayerManager.currentPlayer
	enemy = PlayerManager.currentEnemy

	loadQuestions()

	for i in range(4):
		var button = get_node("Opcoes/Opção%d" % (i + 1))
		buttons.append(button)

		var idx = i
		button.pressed.connect(func(): checkAnswer(idx))

	newQuestion()
	updateHud()

func loadQuestions():
	var file: FileAccess = FileAccess.open("res://data/questions.json", FileAccess.READ)
	
	if not file:
		return

	var allQuestions: Dictionary = JSON.parse_string(file.get_as_text())
	
	file.close()

	for question in allQuestions:
		if question.get("difficultyLevel", 1) == 1:
			questions.append(question)

func newQuestion():
	if questions.is_empty():
		$QuestionLabel.text = "Sem questões carregadas."
		return
	
	current_question = questions[randi() % questions.size()]
	$QuestionLabel.text = current_question["question"]

	for i in range(4):
		buttons[i].text = current_question["options"][i]

func checkAnswer(index: int):
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

func updateHud():
	$PlayerLife.text = "Vida Jogador: %d" % player.character.health
	$EnemyLife.text = "Vida Inimigo: %d" % enemy.health
