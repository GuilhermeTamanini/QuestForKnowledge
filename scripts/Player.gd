extends CharacterBody2D
class_name Player

@export var speed: float = 200
var vel: Vector2 = Vector2.ZERO

func _physics_process(delta):
	handle_input()
	velocity = vel
	move_and_slide()

	for i in range(get_slide_collision_count()):
		var col = get_slide_collision(i).get_collider()
		if col is CharacterBody2D:
			col.interact()

func handle_input():
	vel = Vector2.ZERO
	if Input.is_action_pressed("ui_right"): vel.x += 1
	if Input.is_action_pressed("ui_left"): vel.x -= 1
	if Input.is_action_pressed("ui_down"): vel.y += 1
	if Input.is_action_pressed("ui_up"): vel.y -= 1
	vel = vel.normalized() * speed
