extends Control

func _ready():
	$PlayerSelect.visible = false
	$Main.visible = true
	$Main/ComenzarButton.visible = true

	
func _on_comenzar_pressed():
	$PlayerSelect.visible = true
	$Main.visible = false

