extends Node2D

var number_to_call = []
var called_index = 0
var ball_call_interval = 5
var is_ball_calling = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_a_ball()
	var tween = get_tree().create_tween()
	#tween.tween_property($BallCall, "position", Vector2(500,200), 5 )	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func call_a_ball():
	if is_ball_calling and (called_index < number_to_call.size()):
		$BallCall.call_a_ball(number_to_call[called_index])
		called_index += 1
	
	await get_tree().create_timer(ball_call_interval).timeout
	if is_ball_calling:
		call_a_ball()
	
func set_is_ball_calling(state):
	is_ball_calling = state
	call_a_ball()

func check_if_called(num):
	if num in number_to_call.slice(0, called_index):
		return true;
	
	return false

func get_random_numbers(nums, low, high):
	var random_number_generator = RandomNumberGenerator.new()
	random_number_generator.randomize()

	var random_numbers = []
	while len(random_numbers) < nums:
		var random_int = random_number_generator.randi_range(low, high)
		if random_int not in random_numbers:
			random_numbers.append(random_int)

	return random_numbers
