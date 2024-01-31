extends Node2D

signal vaciada
signal llenada

@export var VELOCIDAD: int
@export var DISIPACION: int

var gases: int = 0
var gases_tapados: int = 0
@export var INICIAL = 50
var barra = INICIAL

func actualizar():
	%Barra.value = snappedi(barra, 1)

	if %Barra.value <= 0:
		vaciada.emit()

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
