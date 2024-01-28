extends Node2D

var ratas = []

@onready var DiamanteRosa = preload("res://scenes/prefabs/DiamanteRosa.tscn")
@onready var DiamanteAzul = preload("res://scenes/prefabs/DiamanteAzul.tscn")

func _ready():
	idle()
	
var case: int

var frame: int = 0

func diamante():
	if randi() % 2 == 0:
		return DiamanteRosa.instantiate()
	else:
		return DiamanteAzul.instantiate()

func emit():
	frame += 1
	
	if frame % 2 == 0:
		var diamante: RigidBody2D = diamante()
		add_child(diamante)
		diamante.global_position = $Diamantes/OjoIzq.global_position
		diamante.gravity_scale = 0
		var rata = ratas[case % ratas.size()]
		diamante.constant_force = diamante.global_position.direction_to(rata.global_position).normalized() * 500
	else:
		var diamante: RigidBody2D = diamante()
		add_child(diamante)
		diamante.global_position = $Diamantes/OjoDer.global_position
		diamante.gravity_scale = 0
		var rata = ratas[(1 - case) % ratas.size()]
		diamante.constant_force = diamante.global_position.direction_to(rata.global_position).normalized() * 500

func idle():
	$Animacion.play("idle")
	$Disparar.wait_time = 4
	$Disparar.start()

func eyes():
	$Animacion.play("eyes")
	$Disparar.wait_time = 1
	$Disparar.start()

func disparar():
	if $Animacion.current_animation == "idle":
		eyes()
		case = randi() % 2
		for i in range(10):
			await get_tree().create_timer(0.1).timeout
			emit()
	else:
		idle()
	
