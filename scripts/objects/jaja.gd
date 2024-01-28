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

func disparar():
	var ja: RigidBody2D = JaWord.instantiate()
	add_child(ja)
	ja.global_position = %Boca.global_position
	ja.gravity_scale = 0
	var rata = ratas.pick_random()
	ja.apuntar = ja.global_position.direction_to(rata.global_position).normalized() * FORCE
