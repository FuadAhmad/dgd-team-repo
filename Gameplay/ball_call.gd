extends Node2D

var number_to_call = []
var called_index = 0
var wait_for_seconds = 5
@export var ball:PackedScene;
var ball_position_Xs = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_ball_position_Xs()
	number_to_call =  get_random_numbers(25, 1, 75)
	call_a_ball(wait_for_seconds)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func call_a_ball(seconds):
	#print(called_index)
	var new_ball = ball.instantiate()
	new_ball.get_child(0).text = str(number_to_call[called_index])#.text = str(number_to_call[called_index])
	add_child(new_ball, 0) #add_child(new_ball)
	#new_ball.position.x = 200
	await get_tree().create_timer(seconds/2).timeout
	print('moving')
	move_balls()
	
	await get_tree().create_timer(seconds/2).timeout
	called_index += 1
	call_a_ball(wait_for_seconds)
	

func move_balls():
	var tbs = get_children()
	var tbs_len = len(tbs)
	print(tbs_len)
	if len(tbs) > 5:
		remove_child(tbs[0])
	for i in range(len(get_children())):
		tbs[i].position.x = ball_position_Xs[i]

func get_ball_position_Xs():
	var tbs = get_children()
	print(len(tbs))
	for c in tbs:
		ball_position_Xs.append(c.position.x)
		
	for c in tbs:
		remove_child(c)
	print('no. childs',len( get_children()))
	
		
func get_random_numbers(nums, low, high):
	var random_number_generator = RandomNumberGenerator.new()
	random_number_generator.randomize()

	var random_numbers = []
	while len(random_numbers) < nums:
		var random_int = random_number_generator.randi_range(low, high)
		if random_int not in random_numbers:
			random_numbers.append(random_int)

	return random_numbers
