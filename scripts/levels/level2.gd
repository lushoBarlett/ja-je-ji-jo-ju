extends Node2D

@onready var Progreso = %Progreso
@onready var Spawn = %Spawn
@onready var Jugadores = %Jugadores
@onready var Jefe = %JeJe
@export var players := []
var spawns : Array


func _ready():
	spawns.insert(0,null)
	spawns.insert(1,[$SpawnRatas/Spawn1])
	spawns.insert(2,[$SpawnRatas/Spawn1,$SpawnRatas/Spawn2])
	spawns.insert(3,[$SpawnRatas/Spawn1,$SpawnRatas/Spawn2,$SpawnRatas/Spawn5])
	spawns.insert(4,[$SpawnRatas/Spawn1,$SpawnRatas/Spawn2,$SpawnRatas/Spawn3,$SpawnRatas/Spawn4])
	var i := 1
	for player in players:
		var rata = preload("res://scenes/prefabs/Rata.tscn").instantiate()
		rata.name = 'Rata' + str(i)
		rata.skin = player['skin']
		rata.position = spawns[players.size()][i-1].position
		rata.player = player['controls']
		Jugadores.add_child(rata)
		i += 1
