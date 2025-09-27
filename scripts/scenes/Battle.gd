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
	var a = randi() % 12 + 1
	var b = randi() % 12 + 1
	var op = randi() % 3
	var ans := 0
	var qtext := ""
	match op:
		0:
			ans = a + b
			qtext = "%d + %d = ?" % [a, b]
		1:
			ans = a - b
			qtext = "%d - %d = ?" % [a, b]
		2:
			ans = a * b
			qtext = "%d × %d = ?" % [a, b]

	var options: Array = [str(ans)]
	while options.size() < 4:
		var alt = ans + int(randf() * 11) - 5
		if alt < 0:
			alt = abs(alt) + 1
		if str(alt) not in options:
			options.append(str(alt))

	options.shuffle()
	var answer_index = options.find(str(ans))
	return {"q": qtext, "options": options, "answer": answer_index}

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
		enemyHealth -= GlobalManager.DAMAGE
		$MarginContainer/VBoxContainer/StatusLabel.text = "Acertou! Causou %d de dano." % GlobalManager.DAMAGE
		if enemyHealth <= 0:
			if isBoss: 
				GlobalHelper.clearManagers()
				GlobalHelper.endGame()
				return
			EnemyManager.removeEnemy(enemy["id"])
	else:
		playerHealth -= GlobalManager.DAMAGE
		if playerHealth <= 0:
			GlobalHelper.clearManagers()
			GlobalHelper.gameOver()
		$MarginContainer/VBoxContainer/StatusLabel.text = "Errou! Você recebeu %d de dano." % GlobalManager.DAMAGE

	_updateStatus()
	_showQuestion()

func _updateStatus():
	$MarginContainer/VBoxContainer/StatusLabel.text += "\nPlayer HP: %d | Inimigo HP: %d" % [
		playerHealth,
		enemyHealth
	]

func _disable_buttons():
	var options_box = $MarginContainer/VBoxContainer/Options
	for child in options_box.get_children():
		child.disabled = true
