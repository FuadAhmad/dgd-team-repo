extends GridContainer

@onready var buttons = get_children()
var number2D = []
var daubed2D = []
var gameplay
var BingoWinScreen 
var powerID = 0
var nonPowerButtonIndexs = []
var nonDaubedButtonIndexs = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_board()
	print("Board's parent: ", get_parent().name)
	gameplay = get_parent()
	BingoWinScreen = gameplay.get_node("BingoWin")
	BingoWinScreen.visible = false
	#print(number2D)
	


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
	#$Button.icon = load("res://assets/powerups/Dab2.png") $Button.text = "88" #
	#$TextureButton2.texture_normal = load("res://assets/powerups/Dab.png")
	#$TextureButton2.get_node("Label").text = str(number2D[0][0])

	for button in buttons:
		nonDaubedButtonIndexs.append(button_index)
		nonPowerButtonIndexs.append(button_index)
		
		var number =  number2D[button_index%5][button_index/5]
		button.connect("pressed", _on_button_daub.bind(button_index, button, number))
		button.text = str(number)#.pop_back())
		button_index += 1
	proper_daub(buttons[12], 12)	

		
func _on_button_daub(index, button, number):
	#print("Pressed button index", indx)
	if daubed2D[index%5][index/5] == 1:
		return
	if powerID == 3:
		powerID = 0
		proper_daub(button, index, 1)
	if gameplay.check_if_called(number):
		proper_daub(button, index)
		#button.Icon = load("res://assets/powerups/Dab.png")
	
func proper_daub(button, index, powerDaub = 0):
	daubed2D[index%5][index/5] = 1
	nonDaubedButtonIndexs.erase(index)
	nonPowerButtonIndexs.erase(index)
	if powerDaub == 1:
		buttons[index].icon = load("res://assets/powerups/Dab2.png")
	else:
		buttons[index].icon = load("res://assets/powerups/Dab.png")
	
	buttons[index].text = ''
	check_for_bingo()
	#button.disabled = true
	

func set_powerID(id):
	powerID = id
	if id == 1: # singleDaub 
		var btnIndx = nonPowerButtonIndexs.pick_random()
		proper_daub(buttons[btnIndx], btnIndx, 1)
	if id == 2: # DoubleDaub 
		var btnIndx = nonPowerButtonIndexs.pick_random()
		proper_daub(buttons[btnIndx], btnIndx, 1)
		btnIndx = nonPowerButtonIndexs.pick_random()
		proper_daub(buttons[btnIndx], btnIndx, 1)
	#id == 3 Wild Daub
		
		
	
func set_bingo_win():
	gameplay.set_is_ball_calling(false)
	BingoWinScreen.visible = true
	
func check_for_bingo():
	#check rows
	for row in daubed2D:
		var summ = 0
		for x in row:
			summ += x
		if summ == 5:
			print("----BINGO--row-")
			set_bingo_win()
			
	#check columns		
	for i in range(0,5):
		var summ = 0
		for j in range(0,5):
			summ += daubed2D[j][i]
		if summ == 5:
			print("----BINGO--col-")
			set_bingo_win()
	
	#check diagonal
	var summ = 0
	for j in range(0,5):
		summ += daubed2D[j][j]
	if summ == 5:
		print("----BINGO--diagonal[i,i]-")
		set_bingo_win()
		
	summ = daubed2D[0][4] + daubed2D[1][3]+ daubed2D[2][2] + daubed2D[3][1] + daubed2D[4][0]
	if summ == 5:
		print("----BINGO--diagonal /-")
		set_bingo_win()
		
	summ = daubed2D[0][0]+ daubed2D[0][4] + daubed2D[4][0] + daubed2D[4][4]
	if summ == 4:
		print("----BINGO--corners-")
		set_bingo_win()
		
func get_random_numbers(nums, low, high):
		var random_number_generator = RandomNumberGenerator.new()
		random_number_generator.randomize()

		var random_numbers = []
		while len(random_numbers) < nums:
			var random_int = random_number_generator.randi_range(low, high)
			if random_int not in random_numbers:
				random_numbers.append(random_int)

		return random_numbers
