extends Node2D

signal vaciada
signal llenada
signal progresada #xd
signal desprogresada 

var VELOCIDAD: int
var DISIPACION: int
var INICIAL = 50

var gases: int = 0
var gases_tapados: int = 0
var barra = INICIAL
var last_value := 0

func actualizar():
	%Barra.value = snappedi(barra, 1)

	if %Barra.value <= 0:
		vaciada.emit()
	if (fmod(%Barra.value, 10) == 0.0):
		if (%Barra.value > last_value):
			progresada.emit()
		elif (%Barra.value < last_value):
			desprogresada.emit()
		last_value = %Barra.value

	if %Barra.value >= 100:
		llenada.emit()

func _ready():
	actualizar()

func _process(delta):
	barra += VELOCIDAD * delta
	barra -= DISIPACION * delta * int(gases_tapados)
	actualizar()

func gas(activo: bool):
	if activo:
		gases_tapados -= 1
	else:
		gases_tapados += 1
