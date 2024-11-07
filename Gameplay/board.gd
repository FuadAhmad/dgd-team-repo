extends GridContainer

@onready var buttons = get_children()
var number2D = []
var daubed2D = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_board()

	print(number2D)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func make_board():
	number2D.append(get_random_numbers(5, 1, 15))
	number2D.append(get_random_numbers(5, 16, 30))
	number2D.append(get_random_numbers(5, 31, 45))
	number2D.append(get_random_numbers(5, 46, 60))
	number2D.append(get_random_numbers(5, 61, 75))

	for i in range(0,5):
		daubed2D.append([0,0,0,0,0])
	set_board_UI()
	
func set_board_UI():
	var button_index = 0
	for button in buttons:
		button.connect("pressed", _on_button_daub.bind(button_index, button))
		button.text = str(number2D[button_index%5][button_index/5])#.pop_back())
		button_index += 1
		
		
func _on_button_daub(indx, button):
	print("Pressed button index", indx)
	button.disabled = true	
	
func get_random_numbers(nums, low, high):
		var random_number_generator = RandomNumberGenerator.new()
		random_number_generator.randomize()

		var random_numbers = []
		while len(random_numbers) < nums:
			var random_int = random_number_generator.randi_range(low, high)
			if random_int not in random_numbers:
				random_numbers.append(random_int)

		return random_numbers
