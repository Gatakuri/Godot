extends InteractableObject

class_name Oven

@export_category("Variables")
@export var _position: Vector3 = Vector3(4.971, 1, -0.1)
@export var _rotation: float = -PI/2

func _interact() -> void:
	print("Usou oven")
	_character_ref.change_position(_position, _rotation)
	#Fazer uma chamada na posição
