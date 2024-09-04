extends Node3D  # Esta classe herda funcionalidades de Node3D para manipulação 3D

class_name SpringArmCharacter  # Define o nome da classe como SpringArmCharacter para facilitar a instanciação no editor

const _mouse_sensibility: float = 0.003  # Sensibilidade do mouse para ajuste de rotação

@export_category("Objects")  # Define uma categoria "Objects" para organizar variáveis exportadas no editor
@export var _spring_arm: SpringArm3D = null  # Referência ao SpringArm3D no editor

func _unhandled_input(_event) -> void:
	# Captura todos os eventos de input não tratados
	if _event is InputEventMouseMotion:  # Verifica se o evento é movimento do mouse
		rotate_y(-_event.relative.x * _mouse_sensibility)  # Rotaciona em Y com base no movimento relativo do mouse
		_spring_arm.rotate_x(-_event.relative.y * _mouse_sensibility)  # Rotaciona em X do SpringArm com base no movimento relativo do mouse
		_spring_arm.rotation.x = clamp(
			_spring_arm.rotation.x, -PI/4, PI/24
		)  # Limita a rotação em X do SpringArm entre -PI/4 e PI/24
