extends Area2D

signal gas(activo: bool)
signal gas_cerrado(gas: Area2D)

var GameFunction = "Gas"

var tapado = false
var segundos = 5

func _process(delta):
	%Humo.emitting = not tapado

	segundos -= delta * int(tapado)

	if segundos <= 0:
		gas_cerrado.emit(self)
		queue_free()

func tapar():
	if not tapado:
		gas.emit(false)

	tapado = true

func destapar():
	if tapado:
		gas.emit(true)

	tapado = false
