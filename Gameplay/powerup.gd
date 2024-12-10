extends HBoxContainer

enum PStatus {
	NONE,
	NEXT,
	READY,
	STOP
}
enum PType {
	NONE,
	SINGLE,
	DOUBLE,
	DAUB,
	INSTANT,
	FREEZE
}
@export var power_status : int
@export var power_id : int
var power_type 
var parent_powerups
	
func _ready():
	parent_powerups = find_node_in_parents("Powerups")
	if parent_powerups:
		pass#print("Parent node found:", parent_powerups)
	else:
		print("Parent node not found")
	set_UI(power_status, power_id)	

func find_node_in_parents(node_name):
	var current_node = self
	while current_node:
		if current_node.name == node_name:
			return current_node
		current_node = current_node.get_parent()
	return null
	
func setPowerup(status, type):
	print("#####setup-----powerup status: " + str(status))
	power_status = status
	power_type = type
	power_id = type
	set_UI(status, type)
	
func set_UI(status, type):
	if status == 0:
		$TextureRect.texture = load("res://assets/powerups/arrow.png")
	elif status == 1:
		$TextureRect.texture = load("res://assets/powerups/ok.png")
	elif status == 2:
		$TextureRect.texture = load("res://assets/powerups/Close.png")
		
	if type == PType.SINGLE:
		$TextureButton.texture_normal = load("res://assets/powerups/SDaub.png")
	elif type == PType.DOUBLE:
		$TextureButton.texture_normal = load("res://assets/powerups/DDaub.png")
	elif type == PType.DAUB:
		$TextureButton.texture_normal = load("res://assets/powerups/Dab2.png")
	elif type == PType.INSTANT:
		$TextureButton.texture_normal = load("res://assets/powerups/InstantBingo.png")
	elif type == PType.FREEZE:
		$TextureButton.texture_normal = load("res://assets/powerups/frozen.png")


func _on_texture_button_pressed() -> void:
	print("-----powerup status: " + str(power_status))
	if power_status == 1:
		print("-----powerup being used.")
		parent_powerups.use_powerup(power_id)
		setPowerup(2, power_id)
