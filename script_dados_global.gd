extends Node

var qtd_vidas = 0
var qtd_flecha = 0
var num_fase = 0

func inicializar_dados():
	qtd_vidas = 3
	qtd_flecha = 5
	num_fase = 1

func perder_vida(valor):
	qtd_vidas -= valor
	print("Vidas restantes:", qtd_vidas)
	if qtd_vidas <= 0:
		return true  # personagem morreu
	return false
