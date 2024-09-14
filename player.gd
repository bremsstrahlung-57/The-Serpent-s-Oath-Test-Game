class_name Player extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var move_speed: float = 50.0
var default_run_speed: float = 10.0
var sprint_run_speed: float = 15.0
var is_attacking: bool = false
var health = 100
var invincibility_duration = 1.0  # Time after taking damage when the player is invincible
var invincibility_timer = 0.0

func _ready() -> void:
	animated_sprite_2d.sprite_frames.set_animation_speed("run", default_run_speed)
	animated_sprite_2d.animation_finished.connect(_on_animation_finished)

func _process(delta: float) -> void:
	if is_attacking:
		return  # Skip movement processing if attacking
	
	# Update invincibility timer
	if invincibility_timer > 0:
		invincibility_timer -= delta

	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if Input.is_action_pressed("shift"):
		velocity = direction * move_speed * 1.5
		animated_sprite_2d.sprite_frames.set_animation_speed("run", sprint_run_speed)
	else:
		velocity = direction * move_speed
		animated_sprite_2d.sprite_frames.set_animation_speed("run", default_run_speed)
	
	if direction.x > 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.animation = "run"
	elif direction.x < 0:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.animation = "run"
	elif direction.y != 0:
		animated_sprite_2d.animation = "run"
	else:
		animated_sprite_2d.animation = "idle"
	
	if Input.is_action_just_pressed("left_click"):
		start_attack()
	elif not animated_sprite_2d.is_playing():
		animated_sprite_2d.play()


func start_attack() -> void:
	is_attacking = true
	animated_sprite_2d.play("attack")
	# Optionally, you can stop the character's movement here
	velocity = Vector2.ZERO

func _on_animation_finished() -> void:
	if animated_sprite_2d.animation == "attack":
		is_attacking = false
		# Resume previous animation state
		if velocity != Vector2.ZERO:
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("idle")
			
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		#print_debug(collider.name)

func _physics_process(delta: float) -> void:
	handleCollision()
	if not is_attacking:
		move_and_slide()

# New method to handle taking damage
func take_damage(amount: int) -> void:
	if invincibility_timer <= 0:  # Only take damage if not invincible
		health -= amount
		if health <= 0:
			die()  # Player death logic
		else:
			invincibility_timer = invincibility_duration  # Start invincibility after taking damage
			animated_sprite_2d.play("hurt")  # Optionally play a hurt animation

func die() -> void:
	queue_free()  # Remove the player from the scene or trigger respawn logic
