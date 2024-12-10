extends Node2D
@onready var board: GridContainer = $"../Board"

@onready var powerup_container: VBoxContainer = $VBoxContainer

@export var powerup:PackedScene
@onready var monster: TextureRect = $"../monster"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var p1 = powerup.instantiate()
	##var ps = p1.get_script()
	#p1.setPowerup(1, 1)
	#powerup_container.add_child(p1)
	pass

func use_powerup(powerid):
	print("----using power id: " + str(powerid))
	board.set_powerID(powerid)
	if powerid == 5:
		monster.UnFreezeBallCall()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
