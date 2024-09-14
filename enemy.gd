extends CharacterBody2D

@onready var hitbox: Area2D = $hitbox  # If you plan to use this separately for attacks
@onready var range_area: Area2D = $hitbox  # Enemy's detection range, make sure this points to correct Area2D
@onready var animation = $AnimatedSprite2D
var speed = 30
var limit = 0.5
var startPosition
var endPosition
var player_in_range = false
var player = null
var health = 100
var attack_cooldown = 1.0
var time_since_last_attack = 0.0

func _ready() -> void:
	startPosition = position
	endPosition = startPosition + Vector2(0, 8*16)
	range_area.connect("body_entered", Callable(self, "_on_range_body_entered"))
	range_area.connect("body_exited", Callable(self, "_on_range_body_exited"))

func _on_range_body_entered(body):
	if body is Player:  # Assuming Player has `class_name "Player"`
		player_in_range = true
		player = body


func _on_range_body_exited(body):
	if body is Player:
		player_in_range = false
		player = null

func changeDirection():
	var tempend = endPosition
	endPosition = startPosition
	startPosition = tempend 

func updateAnimations():
	var animationsString = "idle"
	if player_in_range and player:
		animationsString = "attack"  # Switch to attack animation
	elif velocity.y != 0 or velocity.x != 0:
		animationsString = "walk"
	animation.play(animationsString)

func updateVelocity():
	if player_in_range and player:
		# Follow the player
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
	else:
		# Continue with original patrolling behavior
		var moveDirection = (endPosition - position)
		if moveDirection.length() < limit:
			changeDirection()
		velocity = moveDirection.normalized() * speed

func attack():
	if time_since_last_attack >= attack_cooldown:
		# Attack the player (could reduce health or trigger some effect)
		player.take_damage(10)  # Assuming the player has a take_damage() method
		time_since_last_attack = 0.0  # Reset cooldown timer

func _physics_process(delta):
	time_since_last_attack += delta
	updateVelocity()
	move_and_slide()
	updateAnimations()

	# Check for attack condition
	if player_in_range and player:
		attack()
