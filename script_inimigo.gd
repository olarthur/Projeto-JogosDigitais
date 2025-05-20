extends KinematicBody2D

var velocidade = Vector2.ZERO
var direcao = 1
var esta_vivo = true
var aceleracaoX = 60
var aceleracaoY = 15

func _ready():
	pass

func _process(delta):
	if esta_vivo:
		comportamento()
		velocidade.y += aceleracaoY

		if is_on_floor():
			if direcao == -1:
				velocidade.x = -aceleracaoX
				$Sprite.flip_h = false
			elif direcao == 1:
				velocidade.x = aceleracaoX
				$Sprite.flip_h = true

		velocidade = move_and_slide(velocidade, Vector2.UP)

func comportamento():
	if global_position.x < 0:
		direcao = 1
	elif global_position.x > get_viewport().size.x:
		direcao = -1

	$AnimationPlayer.play("run")

func _on_Area2D_Pulo_body_entered(body):
	if body.name == "Personagem":
		morrer()
		
		
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()
		
func receber_dano(valor_dano):
	if not esta_vivo:
		return
	esta_vivo = false
	$AnimationPlayer.play("death")
	print("Inimigo levou", valor_dano, "de dano")
	queue_free()

func morrer():
	esta_vivo = false
	velocidade = Vector2.ZERO
	$AnimationPlayer.play("death")
	$CollisionShape2D.disabled = true
	$Area2D_Pulo.set_monitoring(false)
	$ProgressBar.visible = false
	yield($AnimationPlayer, "animation_finished")
	queue_free()
