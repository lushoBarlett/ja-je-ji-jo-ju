extends Control

var skins = []
var skinIndex = [0,0,0,0]
var players := []
var ratas := {}
var spawns := [Vector2(275,290),Vector2(740,290),Vector2(150,150)]
signal start(players)

func _ready():
	load_skins()
	$Controls.visible = false
	
func _input(event):
	if visible:
		for i in range(1, 5):
			
			#Cambia sprites de los botones/controles en pantalla
			for action in ["jump", "left", "right", "press"]:
				if (event.is_action_pressed("p"+str(i)+action)):
					get_node("ControlsP"+str(i)+'/'+action).frame += 1
				if (event.is_action_released("p"+str(i)+action)):
					get_node("ControlsP"+str(i)+'/'+action).frame -= 1
			
			if (event.is_action_pressed("p"+str(i)+"jump")):
				var rata = get_node('RataP' + str(i)) #sprite asociado al player
				if rata in ratas:
					var player = ratas[rata]
					player['ready'] = true
				else:	
					add_player(i)

		for player in players:
			if event.is_action_pressed("p" + str(player['controls']) + "right"):
				set_skin(player, 1)
			elif event.is_action_pressed("p" + str(player['controls']) + "left"):
				set_skin(player, -1)
				
			elif event.is_action_pressed("p" + str(player['controls']) + "press"):
				if (player['ready']):
					player['ready'] = false
				else:
					get_node('RataP' + str(player['controls'])).queue_free()
					players.erase(player)
				
func set_skin(player, direction):
	if (not player['ready']):
		player['skin_index'] += direction
		if player['skin_index'] >= skins.size():
			player['skin_index'] = 0
		if player['skin_index'] < 0:
			player['skin_index'] = skins.size() - 1
		var rata = get_node("RataP" + str(player['controls']))
		rata.texture = skins[player['skin_index']]
	
func _on_start_pressed():
	for player in players:
		player['skin'] = skins[player['skin_index']]
	start.emit(players) #pasa el array de dicts con la data de controles/skins


func add_player(player_num):
	var rata = Sprite2D.new()
	rata.name = 'RataP' + str(player_num)
	rata.texture = skins[0]
	rata.position = spawns[(player_num-1)]
	rata.hframes = 2
	rata.vframes = 2
	add_child(rata)
	
	var player := {'controls' : (player_num) , 'skin' : null, 'skin_index' : 0, 'ready' : false}
	players.append(player)
	ratas[rata] = player #Asocia el nodo sprite con el dict. player


func load_skins():
	for file_name in DirAccess.get_files_at("res://assets/skins/"):
		if (file_name.get_extension() == "import"):
			file_name = file_name.replace('.import', '') #'transforma' los .import en .png, necesario para que funcione en el juego exportado
			skins.append(ResourceLoader.load("res://assets/skins/"+file_name))



func on_timer():
	$AnimationPlayer.play('Button_hints')
