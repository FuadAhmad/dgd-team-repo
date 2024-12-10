extends Node2D

@onready var powerup_container: VBoxContainer = $VBoxContainer

@export var powerup:PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p1 = powerup.instantiate()
	var ps = p1.get_script()
	
	ps.setPowerup(2, 2)
	powerup_container.add_child(p1)
	

func use_powerup(powerid):
	print("----using power id: " + str(powerid))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
