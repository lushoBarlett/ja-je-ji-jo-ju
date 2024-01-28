extends Node2D

var spawns = []
var gases = []
var ratas = []

var Nivel: Node2D

func is_gas(child):
	return "GameFunction" in child and child.GameFunction == "Gas"

func asignar_gases():
	Nivel.Progreso.gases = gases.size()

func conectar_eventos_gas(gas):
	gas.gas.connect(Nivel.Progreso.gas)
	gas.gas_cerrado.connect(gas_cerrado)
	
func gas_cerrado(gas):
	gases.erase(gas)
	asignar_gases()
	spawnear_gases()
	spawns.erase(gas.global_position)

func elegir_spawn():
	var todos = Nivel.Spawn.get_children()
	var spawn = todos.pick_random().global_position
	
	var max_tries = 100
	var tries = 0
	while spawns.find(spawn) > -1 and tries < max_tries:
		spawn = todos.pick_random().global_position
		tries += 1
		
	return spawn

func spawnear_gases():
	while gases.size() < 2 or gases.size() < ratas.size():
		var gas = preload("res://scenes/prefabs/Gas.tscn").instantiate()
		conectar_eventos_gas(gas)
		
		gas.global_position = elegir_spawn()
		spawns.append(gas.global_position)
		
		Nivel.add_child(gas)
		gases.append(gas)
		
	asignar_gases()

func encontrar_ratas():
	for child in Nivel.Jugadores.get_children():
		ratas.append(child)

func asignar_ratas():
	Nivel.Jefe.ratas = ratas
	
func conectar_muertes():
	for rata in ratas:
		rata.muerte.connect(mori)
		
func conectar_progreso():
	Nivel.Progreso.llenada.connect(perdi)
	Nivel.Progreso.vaciada.connect(gane)

@export var NIVEL = 1

func _ready():
	cargar_nivel()

func mori(rata):
	# we assume there are two rats only
	# two players and one losing is a little harder
	# tha single player
	ratas.erase(rata)
	Nivel.Progreso.DISIPACION *= 1.8
	if ratas.size() == 0:
		perdi()

func perdi():
	var GameOver = preload("res://scenes/ui/GameOver.tscn").instantiate()
	GameOver.find_child("Reintentar").pressed.connect(cargar_nivel)
	get_tree().paused = true
	Nivel.add_child(GameOver)

func cargar_nivel():
	spawns = []; gases = []; ratas = []
	
	if Nivel:
		remove_child(Nivel)
	
	Nivel = load("res://scenes/levels/Level" + str(NIVEL) + ".tscn").instantiate()
	add_child(Nivel)
	get_tree().paused = false
	
	encontrar_ratas()
	asignar_ratas()
	conectar_muertes()
	conectar_progreso()
	spawnear_gases()

func gane():
	get_tree().paused = true
	var Screen: Control
	
	if NIVEL < 5:
		Screen = preload("res://scenes/ui/GameNext.tscn").instantiate()
		Screen.find_child("Siguiente").pressed.connect(cargar_nivel)
		NIVEL += 1
	else:
		Screen = preload("res://scenes/ui/GameWon.tscn").instantiate()
		
	Nivel.add_child(Screen)
