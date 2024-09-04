extends Node3D  # Esta classe estende Node3D para manipular funcionalidades em 3D

class_name CharacterArmature  # Define o nome da classe para facilitar a instanciação no editor

const LERP_VELOCITY : float = 0.15  # Constante que controla a suavidade da interpolação de rotação

@export_category("Objects")  # Cria uma categoria no editor para organizar as variáveis exportadas
@export var _character: CharacterBody3D = null  # Referência ao objeto CharacterBody3D exportada para o editor
@export var _animation: AnimationPlayer = null  # Referência ao objeto AnimationPlayer exportada para o editor

func apply_rotation(_velocity: Vector3) -> void:
	# Aplica rotação suave baseada na direção da velocidade
	rotation.y = lerp_angle(
		rotation.y,  # Rotação inicial baseada na velocidade Y
		atan2(-_velocity.x, -_velocity.z),  # Rotação alvo calculada a partir de X e Z invertidos da velocidade
		LERP_VELOCITY  # Controla a suavidade da interpolação
	)

func animate(_velocity: Vector3) -> void:
	if _velocity:
		if _character.is_running():
			_animation.play("Run")  # Animação de corrida se estiver correndo
			return
		_animation.play("Walk")  # Animação de caminhada se não estiver correndo
		return
	_animation.play("Idle")  # Animação padrão quando não há velocidade
