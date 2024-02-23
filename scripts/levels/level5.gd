extends Node2D

@onready var Progreso = %Progreso
@onready var Spawn = %Spawn
@onready var Jugadores = %Jugadores
@onready var Jefe = %JuJu
@export var player_count : int
@export var skins = []
var spawns : Array

func _ready():
	spawns.insert(0,null)
	spawns.insert(1,null)
	spawns.insert(2,[$SpawnRatas/Spawn1,$SpawnRatas/Spawn2])
	spawns.insert(3,[$SpawnRatas/Spawn1,$SpawnRatas/Spawn2,$SpawnRatas/Spawn5])
	spawns.insert(4,[$SpawnRatas/Spawn1,$SpawnRatas/Spawn2,$SpawnRatas/Spawn3,$SpawnRatas/Spawn4])
	for i in range(player_count):
		var rata = preload("res://scenes/prefabs/Rata.tscn").instantiate()
		rata.name = 'Rata' + str(i+1)
		rata.skin = skins[i]
		rata.position = spawns[player_count][i].position
		rata.player = i+1
		Jugadores.add_child(rata)
