extends Node2D

func _ready():
	visible = false


func _process(delta):
	if (Input.is_action_just_pressed("pausar_jogo")):
		visible = not visible
		get_tree().paused = visible
