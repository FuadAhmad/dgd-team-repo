extends Node

class card_utils:
	# Called when the node enters the scene tree for the first time.
	func _ready() -> void:
		pass # Replace with function body.

	func get_random_numbers(nums, low, high):
		var random_number_generator = RandomNumberGenerator.new()
		random_number_generator.randomize()

		var random_numbers = []
		while len(random_numbers) < nums:
			var random_int = random_number_generator.randi_range(low, high)
			if random_int not in random_numbers:
				random_numbers.append(random_int)

		print(random_numbers)
