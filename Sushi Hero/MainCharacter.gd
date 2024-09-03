extends CharacterBody3D  # Esta classe herda funcionalidades de CharacterBody3D para manipulação 3D do personagem

class_name Character  # Define o nome da classe como Character para facilitar a instânciação no editor

const Normal_Speed: float = 5.0  # Velocidade normal do personagem
const Sprint_Speed: float = 9.0  # Velocidade de corrida do personagem

var current_speed: float  # Variável que armazena a velocidade atual do personagem

@export_category("Objects")  # Define uma categoria "Objects" para organizar variáveis exportadas no editor
@export var _body: Node3D = null  # Referência ao corpo do personagem no editor
@export var spring_arm_offset: Node3D = null  # Referência ao offset do braço elástico no editor

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Define o modo de captura de mouse quando o jogo inicia

func _physics_process(_delta: float) -> void:
	move()  # Chama a função de movimento do personagem
	move_and_slide()  # Aplica física de movimento e colisão ao personagem
	_body.animate(velocity)  # Atualiza a animação do corpo baseada na velocidade atual

func move() -> void:
	var input_direction: Vector2 = Input.get_vector(
		"move_right", "move_left",
		"move_backward", "move_forward"
	)  # Obtém a direção de movimento do input map
	var direction: Vector3 = transform.basis * Vector3(
		input_direction.x,
		0,
		input_direction.y
	).normalized()  # Converte a direção 2D em 3D e normaliza para movimento suave

	is_running()  # Verifica se o personagem está correndo

	direction = direction.rotated(Vector3.UP, spring_arm_offset.rotation.y)  # Rotaciona a direção conforme o braço elástico

	if direction:
		velocity.x = direction.x * current_speed  # Define a velocidade no eixo x com base na direção e na velocidade atual
		velocity.z = direction.z * current_speed  # Define a velocidade no eixo z com base na direção e na velocidade atual
		_body.apply_rotation(velocity)  # Aplica rotação suave ao corpo com base na velocidade
		return

	# Caso não haja direção, diminui a velocidade gradualmente
	velocity.x = move_toward(velocity.x, 0, current_speed)
	velocity.z = move_toward(velocity.z, 0, current_speed)

func is_running() -> bool:
	if Input.is_action_pressed("shift"):  # Verifica se a tecla Shift está pressionada
		current_speed = Sprint_Speed  # Define a velocidade atual como velocidade de corrida
		return true  # Retorna true indicando que o personagem está correndo

	current_speed = Normal_Speed  # Define a velocidade atual como velocidade normal
	return false  # Retorna false indicando que o personagem não está correndo
