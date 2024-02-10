extends CharacterBody2D

@onready var Fuego = preload("res://scenes/prefabs/Fuego.tscn")

@export var Spawn : Node2D


var ratas = []
var SPEED := 15000
var SIGNO := 0
var was_on_floor := false
var GameFunction := 'Enemy'
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 2 

func _ready():
	teleport('ground')
	
func _physics_process(delta):
	if is_on_floor():
		velocity.x = SIGNO * SPEED * delta
	else:
		velocity.y += gravity * delta
		if SIGNO != 0: #Para que no asigne mientras esta en la animación de salida
			signo_random()
	move_and_slide()
	if (is_on_wall()):
		SIGNO *= -1
	
	was_on_floor = is_on_floor()

func on_timer():
	while (not is_on_floor() and not was_on_floor):#Para que no tire tp cayendo,
		await get_tree().create_timer(0.5).timeout #queda horrible visualmente
	SIGNO = 0
	$Player.play('ground')
	
func teleport(anim):
	if(anim == 'ground'):
		global_position = Spawn.get_children().pick_random().global_position
		$Player.play('aparecer')
		
	elif(anim == 'aparecer'):
		signo_random() #No se mueve en x hasta terminar la animacion

func interactuar(r):
	if r in ratas:
		r.die()

func _on_progreso(): #Progreso positivo para las ratas, cuando baja la barra
	SPEED += 1000

func signo_random():
		if randi() % 2:
			SIGNO = 1
		else :
			SIGNO = -1
