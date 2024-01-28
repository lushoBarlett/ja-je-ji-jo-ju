extends CharacterBody2D

signal muerte(rata: CharacterBody2D)

var GameFunction = "Player"

const SPEED = 400.0
const JUMP_VELOCITY = -900.0

@export var player: int

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 1.5

var gases = []

func p_action(action: String):
	return "p" + str(player) + action

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func apply_movement(delta):
	var direction = Input.get_axis(p_action("left"), p_action("right"))
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func start_jump():
	velocity.y = JUMP_VELOCITY

func jump_control():
	if Input.is_action_just_pressed(p_action("jump")) and is_on_floor():
		start_jump()
	elif Input.is_action_pressed(p_action("jump")):
		pass # keeps jumping
	elif velocity.y < 0:
		velocity.y *= 0.5 # damp jump action

func accion_tapar():
	for gas in gases:
		gas.tapar()

func accion_destapar():
	for gas in gases:
		gas.destapar()

func tapar_control():
	if Input.is_action_pressed(p_action("press")) and is_on_floor():
		accion_tapar()
	else:
		accion_destapar()

func select_sprite():
	if velocity.y < 0:
		%AnimatedSprite2D.play("jump1")
	elif velocity.y > 0:
		%AnimatedSprite2D.play("jump2")
	elif velocity.x != 0:
		%AnimatedSprite2D.play("walk")
	else:
		%AnimatedSprite2D.play("idle")

func select_sprite_rotation():
	if velocity.x == 0:
		%AnimatedSprite2D.rotation = 0
	elif velocity.length() != 0:
		%AnimatedSprite2D.rotation = clampf(atan(velocity.y / velocity.x) , -1, 1)
	else:
		%AnimatedSprite2D.rotation = 0

func select_sprite_orientation():
	if velocity.x > 0:
		%AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		%AnimatedSprite2D.flip_h = true

func _physics_process(delta):
	apply_gravity(delta)
	apply_movement(delta)
	jump_control()
	tapar_control()
	move_and_slide()
	select_sprite()
	select_sprite_rotation()
	select_sprite_orientation()

func is_gas(g):
	return "GameFunction" in g and g.GameFunction == "Gas"
	
func is_enemy(e):
	return "GameFunction" in e and e.GameFunction == "Enemy"

func die():
	muerte.emit(self)
	queue_free()

func _on_tocando(b):
	if is_gas(b):
		gases.append(b)
	elif is_enemy(b):
		die()
	
func _on_dejando(g):
	if is_gas(g):
		gases.erase(g)
		g.destapar()
