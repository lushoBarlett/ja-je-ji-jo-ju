extends Node2D

@onready var _follow: PathFollow2D = get_parent()
@export var SPEED: float
@export var FORCE: float

@onready var Fuego = preload("res://scenes/prefabs/Fuego.tscn")

var ratas = []

var time = 0

func _ready():
	%Caminata.play("crazy")

func current_ratio(delta):
	time += delta
	return (1 + sin(SPEED * time)) / 2

var case: int

func get_random_unit() -> Vector2:
	var x1 = randf_range(-1, 1)
	var x2 = randf_range(-1, 1)

	while x1*x1 + x2*x2 >= 1:
		x1 = randf_range (-1, 1)
		x2 = randf_range (-1, 1)

	var pos = Vector2(
	2 * x1 * sqrt(1 - x1*x1 - x2*x2),
	2 * x2 * sqrt(1 - x1*x1 - x2*x2))

	return pos * randf_range(0, 1)

func emit():
	if randi() % 20 == 0:
		var fuego: RigidBody2D = Fuego.instantiate()
		add_child(fuego)
		fuego.global_position = %BrazoIzq/Boca.global_position
		fuego.gravity_scale = 0
		var rata = ratas[case % ratas.size()]
		fuego.constant_force = fuego.global_position.direction_to(rata.global_position).normalized() * FORCE
		fuego.constant_force += get_random_unit() * 5
	
	if randi() % 20 == 0:
		var fuego: RigidBody2D = Fuego.instantiate()
		add_child(fuego)
		fuego.global_position = %BrazoDer/Boca.global_position
		fuego.gravity_scale = 0
		var rata = ratas[(1 - case) % ratas.size()]
		fuego.constant_force = fuego.global_position.direction_to(rata.global_position).normalized() * FORCE
		fuego.constant_force += get_random_unit() * 5

func _physics_process(delta):
	if %Caminata.current_animation == "crazy":
		%BrazoIzq.look_at(ratas[     case  % ratas.size()].global_position)
		%BrazoDer.look_at(ratas[(1 - case) % ratas.size()].global_position)
		%BrazoIzq.rotation += 2.5 * PI / 2
		%BrazoDer.rotation -= PI / 6
		emit()
	else:
		%BrazoIzq.rotation = 0
		%BrazoDer.rotation = 0
		
	var ratio = current_ratio(delta)
	_follow.set_progress_ratio(ratio)

func disparar():
	if %Caminata.current_animation == "idle":
		%Caminata.play("crazy")
		%Caminata.speed_scale = 2
		%Timer.wait_time = 4
		%Timer.start()
		case = randi() % 2
	else:
		%Caminata.play("idle")
		%Caminata.speed_scale = 1
		%Timer.wait_time = 8
		%Timer.start()
