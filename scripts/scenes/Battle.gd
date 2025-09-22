extends Control

var enemy: IEnemy = GlobalManager.currentEnemy
var player: IPlayer = GlobalManager.currentPlayer
var current_answer := -1

func _ready():
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
		btn.pressed.connect(Callable(self, "_on_option_pressed").bind(i))
		options_box.add_child(btn)

func _on_option_pressed(selected_index):
	if selected_index == current_answer:
		enemy.takeDamage()
		$MarginContainer/VBoxContainer/StatusLabel.text = "Acertou! Causou %d de dano." % GlobalManager.DAMAGE
	else:
		enemy.takeDamage()
		#player.takeDamage()
		$MarginContainer/VBoxContainer/StatusLabel.text = "Errou! Você recebeu %d de dano." % GlobalManager.DAMAGE

	_updateStatus()

func _updateStatus():
	$MarginContainer/VBoxContainer/StatusLabel.text += "\nPlayer HP: %d | Inimigo HP: %d" % [player.health, enemy.health]

#func _checkEnd() -> bool:
	#if enemy_hp <= 0:
		#$MarginContainer/VBoxContainer/QuestionLabel.text = "Você venceu!"
#
		#GlobalHelper.goToWorld()
		#return true
	#elif player_hp <= 0:
		#$MarginContainer/VBoxContainer/QuestionLabel.text = "Você perdeu!"
		#GlobalHelper.gameOver()
		#return true
	#return false

func _disable_buttons():
	var options_box = $MarginContainer/VBoxContainer/Options
	for child in options_box.get_children():
		child.disabled = true
