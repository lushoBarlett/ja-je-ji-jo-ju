extends Node2D

@onready var Money = preload("res://scenes/prefabs/Money.tscn")

var ratas = []

func idle():
	%Danza.play("idle")
	$Escopeta.wait_time = 10
	$Escopeta.start()

func money():
	%Danza.play("money")
	$Escopeta.wait_time = 8
	$Escopeta.start()

func _ready():
	idle()

func get_random_unit() -> Vector2:
	var x1 = randf_range(-1, 1)
	var x2 = randf_range(-1, 1)

	while x1*x1 + x2*x2 >= 1:
		x1 = randf_range (-1, 1)
		x2 = randf_range (-1, 1)

	return Vector2(x1, x2) * randf_range(0, 1)

func escopeta():
	for i in range(20):
		var m: RigidBody2D = Money.instantiate()
		add_child(m)
		m.global_position = $BrazoExtendido/USD.global_position
		m.rotation = 0
		var force = Vector2.UP * 700 + Vector2.RIGHT * 100
		force += get_random_unit() * 2000
		m.apply_central_impulse(force)
		print(force)

func preparar_escopeta():
	money() if %Danza.current_animation == "idle" else idle()
