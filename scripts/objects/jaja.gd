extends Node2D

@onready var _follow: PathFollow2D = get_parent()
@export var SPEED: float
@export var FORCE: float

@onready var JaWord = preload("res://scenes/prefabs/JaWord.tscn")

var ratas = []

var time = 0

func _ready():
	%Caminata.play("move")

func current_ratio(delta):
	time += delta
	return (1 + sin(SPEED * time)) / 2

func _physics_process(delta):
	var speed = cos(SPEED * time)

	if speed > 0:
		%Caminata.flip_h = true
	elif speed < 0:
		%Caminata.flip_h = false

	%Caminata.speed_scale = abs(speed)

	var ratio = current_ratio(delta)
	_follow.set_progress_ratio(ratio)

func crear_ja(gpos: Vector2):
	var ja: RigidBody2D = JaWord.instantiate()

	ja.global_position = gpos

	ja.gravity_scale = 0

	add_child(ja)

	return ja

func elegir_destino():
	return ratas.pick_random().global_position

func disparar():
	var ja = crear_ja(%Boca.global_position)
	var destino = elegir_destino()
	ja.apuntar = ja.global_position.direction_to(destino).normalized() * FORCE
