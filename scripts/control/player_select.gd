extends Control

var skin1 = preload("res://assets/rata.png")
var skin2 = preload("res://assets/rata_blanca.png")
var skins = [skin1,skin2]
var skinIndex = [0,0,0,0]
var player_count := 2
signal start(players_count, skins)

func _ready():
	print(get_parent().player_count)
func _process(delta):
	for i in range(player_count):
		if (Input.is_action_just_pressed("p"+str(i+1)+"right")):
			skinIndex[i] += 1
			if skinIndex[i] > skins.size() - 1:
				skinIndex[i] = 0
			set_skins()
		if (Input.is_action_just_pressed("p"+str(i+1)+"left")):
			skinIndex[i] -= 1
			if skinIndex[i] < 0:
				skinIndex[i] = skins.size() - 1
			set_skins()
func set_skins():
	for i in range(player_count):
		get_node("Player" + str(i + 1)).texture = skins[skinIndex[i]]

func _on_start_pressed():
	var chosen_skins = skinIndex.map(func(i): return skins[i])
	start.emit(player_count, chosen_skins)
