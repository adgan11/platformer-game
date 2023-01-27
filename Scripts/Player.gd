extends KinematicBody2D

#0, 1, -1, 2, 5, -10

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000

var coins = 0
var velocity = Vector2.ZERO

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed

func _on_Area2D_area_entered(area):
	if area.is_in_group("coin"):
		coins += 1
		print(coins)
		get_parent().get_node("Label").text = ("Coins: " + str(coins))
		area.get_parent().queue_free()
