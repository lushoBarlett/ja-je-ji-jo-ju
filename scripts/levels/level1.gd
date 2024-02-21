extends Node2D

@onready var Progreso = %Progreso
@onready var Spawn = %Spawn
@onready var Jugadores = %Jugadores
@onready var Jefe = %JaJa
@export var player_count : int
@export var skins = []

func _ready():
	for i in range(player_count):
		var rata = preload("res://scenes/prefabs/Rata.tscn").instantiate()
		rata.name = 'Rata' + str(i+1)
		rata.skin = skins[i]
		rata.position = Vector2(1830,500)
		rata.player = i+1
		Jugadores.add_child(rata)
