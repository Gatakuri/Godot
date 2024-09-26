extends Node3D

class_name InteractableObject

var _can_interact: bool = false
var _character_ref: Character = null

@export_category("Objects")
@export var _feedback: MeshInstance3D = null

func can_interact(_state: bool, _body: Character = null) -> void:
	_feedback.visible = _state
	_character_ref = _body
	_can_interact = _state
	
func _physics_process(delta: float) -> void:
	if _character_ref == null:
		return
		
	if _can_interact and Input.is_action_just_pressed("interact"):
		change_state(false)
		_interact()
		
		
func _interact() -> void:
	pass
	
	
func change_state(_state: bool) -> void:
	if _character_ref != null:
		_character_ref.freeze(not _state)
		
		if _character_ref.can_interact:
			_can_interact = _state
			_feedback.visible = _state
		
