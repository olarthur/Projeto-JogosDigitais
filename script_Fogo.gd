extends KinematicBody2D

var aceleracaoX = 550
var direcao = 1
var velocidade  = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	if (direcao==1):
		velocidade.x = direcao * aceleracaoX
		$Sprite.flip_h = false
		
	verificar_colisao()
	
	move_and_slide(velocidade)
	
func verificar_colisao():
	if ($RayCast2D.is_colliding()):
		if ($RayCast2D.get_collider().name=="Inimigo"):
			$RayCast2D.get_collider().receber_dano(2)
			get_parent().queue_free()
