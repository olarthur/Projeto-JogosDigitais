extends KinematicBody2D

var aceleracaoX = 450
var aceleracaoY = 50
var forca_pulo  = 1300
var velocidade  = Vector2.ZERO
var direcao     = 1
var animando    = false

func _ready():
	$Camera2D.limit_top  = 0
	$Camera2D.limit_left = 0
	$Camera2D.limit_bottom = get_viewport().size.y
	$Camera2D.limit_right = 2500

func _process(delta):
	velocidade.x = 0
	velocidade.y += aceleracaoY
	
	if (Input.is_action_pressed("ui_left")):
			velocidade.x = -aceleracaoX	
			direcao = -1
			$Sprite.flip_h = true
		
	elif (Input.is_action_pressed("ui_right")):
			velocidade.x = aceleracaoX	
			direcao = 1
			$Sprite.flip_h = false
			
			
	if (is_on_floor() and not animando):
			if (velocidade.x==0):
				$AnimationPlayer.play("idle")
			else:
				$AnimationPlayer.play("run")
				
	if (Input.is_action_just_pressed("ui_up") and is_on_floor()):
			velocidade.y = -forca_pulo
			$AnimationPlayer.play("pulando")	
				
	if (is_on_floor() and not animando):
			if (Input.is_action_just_pressed("ui_accept") and DadosGlobais.qtd_flecha>0):     
				$AnimationPlayer.play("ataque")
				animando = true				
		
	velocidade = move_and_slide(velocidade, Vector2.UP)

func verificar_colisao_ataque():
	var Inimigo = null
	
	if ($RayCast2DMaoDir.is_colliding() and $RayCast2DMaoDir.get_collider().name=="Inimigo"):
		Inimigo = $RayCast2DMaoDir.get_collider()
	
	if ($RayCast2DMaoEsq.is_colliding() and $RayCast2DMaoEsq.get_collider().name=="Inimigo"):
		Inimigo = $RayCast2DMaoEsq.get_collider()
	
	if (Inimigo!=null):
		Inimigo.receber_dano(1)
		
func atirar_flecha():
	if DadosGlobais.qtd_flecha <= 0:
		return  # Não lança se não houver flechas

	DadosGlobais.qtd_flecha -= 1
	var cena_flecha = preload("res://cenario_fogo.tscn")
	var nova_flecha = cena_flecha.instance()
	get_parent().add_child(nova_flecha)
	nova_flecha.position = position
	nova_flecha.direcao = direcao
	
func _input(event):
	if event.is_action_pressed("atacar"):
		soltar_fogo()

func soltar_fogo():
	var fogo_scene = preload("res://cenario_Fogo.tscn")
	var fogo = fogo_scene.instance()
	fogo.global_position = $Boca.global_position
	get_tree().current_scene.add_child(fogo)
	
	
func animacao_finalizada(anim_name):
	if(anim_name=="death"):
		get_tree().change_scene("res://cena_splash.tscn") # Replace with function body.

	if (anim_name=="attack"):
		verificar_colisao_ataque()
		$RayCast2DMaoEsq.enabled = false
		$RayCast2DMaoDir.enabled = false
	
	animando = false


func esta_vivo():
	if (DadosGlobais.qtd_vidas<=0):
		if (not animando and is_on_floor()):
			$AnimationPlayer.play("morrendo")
			animando = true
			aceleracaoX = 0
			forca_pulo  = 0
		return false
	else:
		return true
		
		
	



