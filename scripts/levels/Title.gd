extends Control
var player_count := 2

func _ready():
	$PlayerSelect.visible = false
	$Main.visible = true
	$Main/ComenzarButton.visible = true
	$Main/'2Players'.visible = false
	$Main/'3Players'.visible = false
	
func _on_comenzar_pressed():
	$Main/ComenzarButton.visible = false
	$Main/'2Players'.visible = true
	$Main/'3Players'.visible = true
	
func _on_2players_pressed():
	player_count = 2
	$PlayerSelect.player_count = 2
	$PlayerSelect.visible = true
	$Main.visible = false
func _on_3players_pressed():
	$PlayerSelect.player_count = 3
	$PlayerSelect.visible = true
	$Main.visible = false
