extends Node2D

@onready var Progreso = %Progreso
@onready var Spawn = %Spawn
@onready var Jugadores = %Jugadores
@onready var Jefe = %JiJi
@export var player_count : int

func _ready():
	if (player_count >= 3) :
		var skin3 = preload("res://assets/rata.png")
		var rata3 = preload("res://scenes/prefabs/Rata.tscn").instantiate()
		rata3.position = Vector2(1830,500)
		rata3.player = 3
		rata3.skin = skin3
		Jugadores.add_child(rata3)
