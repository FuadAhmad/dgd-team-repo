extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($frozen, "scale", Vector2(2,2), 1)
	tween.set_parallel(true)
	tween.tween_property($frozen, "position", get_parent().get_node("BallCall").position, 2)	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
