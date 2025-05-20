extends Node2D

func _ready():
	DadosGlobais.inicializar_dados()
	
	
func _process(delta):
	$LabelCoracao.text = "X" + str(DadosGlobais.qtd_vidas)
	$LabelFogo.text = "X" + str(DadosGlobais.qtd_flecha)
