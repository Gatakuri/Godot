extends InteractableObject

var _item_ref: MeshInstance3D = null

@export var _ingredients: Node3D = null

@export_category("Variables")
@export var _rotation: float = PI/2
@export var _position: Vector3 = Vector3(1.24,1,-1.432)

func _interact() -> void:
	print("Usou cutting table")
	_character_ref.change_position(_position, _rotation)
	#Chamar a interface
	
func chop(_items: Array) -> void:
	_item_ref = _ingredients.get_node(_items[randi() % _items.size()].to_pascal_case())
	_item_ref.show()
	
	await get_tree().create_timer(5.0).timeout
	_item_ref.hide()
