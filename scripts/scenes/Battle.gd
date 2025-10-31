### Battle.gd
extends Control

var enemyHealth: int
var playerHealth: int
var isBoss: bool
var enemy: Dictionary = EnemyManager.getEnemyById(GlobalManager.currentEnemyId)
var current_answer := -1

func _ready():
	enemyHealth = enemy["health"]
	isBoss = enemy["isBoss"]
	playerHealth = 20
	randomize()
	_showQuestion()
	_updateStatus()

func _generateQuestion() -> Dictionary:
	var questions = GlobalManager.getQuestionsForCurrentMap()
	if questions.is_empty():
		return {"q": "Sem perguntas disponíveis", "options": ["..."], "answer": 0}

	var question = questions[randi() % questions.size()]
	var options: Array = []
	for a in question["answers"]:
		options.append(a["answer"])

	var correct_index = 0
	for i in range(options.size()):
		if question["answers"][i]["correct"]:
			correct_index = i
			break

	return {"q": question["question"], "options": options, "answer": correct_index}


func _showQuestion():
	var qdata = _generateQuestion()
	$MarginContainer/VBoxContainer/QuestionLabel.text = qdata.q
	current_answer = qdata.answer

	var options_box = $MarginContainer/VBoxContainer/Options

	for child in options_box.get_children():
		child.queue_free()

	for i in range(qdata.options.size()):
		var btn = Button.new()
		btn.text = qdata.options[i]
		btn.pressed.connect(Callable(self, "_onOptionPressed").bind(i))
		options_box.add_child(btn)

func _onOptionPressed(selected_index):
	if selected_index == current_answer:
		$MarginContainer/VBoxContainer/StatusLabel.text = "Acertou! Causou %d de dano." % GlobalManager.DAMAGE

		enemyHealth -= GlobalManager.DAMAGE

		_updateStatus()
		if enemyHealth > 0:
			_showQuestion()
			return
		if isBoss:
			EnemyManager.removeEnemy(enemy["id"])
			GlobalHelper.killBoss()
			return
		EnemyManager.removeEnemy(enemy["id"])
	else:
		$MarginContainer/VBoxContainer/StatusLabel.text = "Errou! Você recebeu %d de dano." % GlobalManager.DAMAGE

		enemyHealth -= GlobalManager.DAMAGE

		_updateStatus()
		if enemyHealth > 0:
			_showQuestion()
			return
		if isBoss:
			EnemyManager.removeEnemy(enemy["id"])
			GlobalHelper.killBoss()
			return
		EnemyManager.removeEnemy(enemy["id"])

		#playerHealth -= GlobalManager.DAMAGE

		#_updateStatus()
		#if playerHealth > 0:
			#_showQuestion()
			#return
#
		#GlobalHelper.clearManagers()
		#GlobalHelper.gameOver()

func _updateStatus():
	$MarginContainer/VBoxContainer/StatusLabel.text += "\nPlayer HP: %d | Inimigo HP: %d" % [
		playerHealth,
		enemyHealth
	]
