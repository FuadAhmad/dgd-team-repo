extends HBoxContainer

enum PStatus {
	NONE,
	NEXT,
	READY,
	STOP
}
enum PType {
	SINGLE,
	DOUBLE,
	DAUB,
	INSTANT,
	FREEZE
}
@export var power_status : int
var power_type 
var parent_powerups
	
func _ready():
	parent_powerups = find_node_in_parents("Powerups")
	if parent_powerups:
		pass#print("Parent node found:", parent_powerups)
	else:
		print("Parent node not found")

func find_node_in_parents(node_name):
	var current_node = self
	while current_node:
		if current_node.name == node_name:
			return current_node
		current_node = current_node.get_parent()
	return null
	
func setPowerup(status, type):
	power_status = status
	power_type = type
	set_UI(status, type)
	
func set_UI(status, type):
	if status == 0:
		$TextureRect.texture = load("res://assets/powerups/arrow.png")
	elif status == 1:
		$TextureRect.texture = load("res://assets/powerups/ok.png")
	elif status == 2:
		$TextureRect.texture = load("res://assets/powerups/Close.png")
		
	if type == PType.SINGLE:
		$TextureButton.texture = load("res://assets/powerups/SDaub.png")
	elif type == PType.DOUBLE:
		$TextureButton.texture = load("res://assets/powerups/DDaub.png")
	elif type == PType.DAUB:
		$TextureButton.texture = load("res://assets/powerups/Dab2.png")
	elif type == PType.INSTANT:
		$TextureButton.texture = load("res://assets/powerups/InstantBingo.png")
	elif type == PType.FREEZE:
		$TextureButton.texture = load("res://assets/powerups/DDaub.png")


func _on_texture_button_pressed() -> void:
	print("-----powerup status: " + str(power_status))
	if power_status == 1:
		print("-----powerup being used.")
		parent_powerups.use_powerup(2)
