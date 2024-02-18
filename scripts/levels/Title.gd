extends Control
signal start(players_count)

func _ready():
	$ComenzarButton.visible = true
	$'2Players'.visible = false
	$'3Players'.visible = false
	
func _on_comenzar_pressed():
	$ComenzarButton.visible = false
	$'2Players'.visible = true
	$'3Players'.visible = true
	
func _on_2players_pressed():
	start.emit(2)
	
func _on_3players_pressed():
	start.emit(3)
