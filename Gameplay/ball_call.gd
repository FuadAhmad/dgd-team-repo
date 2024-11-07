extends Node2D

var number_to_call = []

var wait_for_seconds
@export var ball:PackedScene;
var ball_position_Xs = []
var tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_ball_position_Xs()
	number_to_call =  get_parent().number_to_call #get_random_numbers(25, 1, 75)
	wait_for_seconds = get_parent().ball_call_interval
	#call_a_ball(wait_for_seconds)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func call_a_ball(number):
	#print(called_index)
	var new_ball = ball.instantiate()
	new_ball.get_child(0).text = str(number)#.text = str(number_to_call[called_index])
	add_child(new_ball) #add_child(new_ball, 0)
	#new_ball.position.x = 200
	tween = get_tree().create_tween()
	tween.tween_property(new_ball, "scale", Vector2(.8,.8), wait_for_seconds/1.5)
	
	await get_tree().create_timer(wait_for_seconds/2).timeout
	move_old_balls()#move_balls()
	await get_tree().create_timer(wait_for_seconds/2).timeout
	
	

func move_balls():
	var tbs = get_children()
	var tbs_len = len(tbs)
	print(tbs_len)
	if len(tbs) > 5:
		remove_child(tbs[-1])
	for i in range(len(get_children())):
		tbs[i].position.x = ball_position_Xs[i]

func move_old_balls():
	var tbs = get_children()
	var tbs_len = len(tbs)
	#print(tbs_len)
	if len(tbs) > 5:
		remove_child(tbs[0])
	
	tbs = get_children()
	tbs_len = len(tbs)
	for i in range(0, len(tbs)):
		#print(tbs[i].name)#tbs[i].position.x = ball_position_Xs[tbs_len - i-1]
		tween = get_tree().create_tween() #tween.set_parallel(true)
		tween.tween_property(tbs[i], "position", ball_position_Xs[tbs_len - i-1], wait_for_seconds/2.5 )
		#break#tween.start()
			
func get_ball_position_Xs():
	var tbs = get_children()
	#print(len(tbs))
	for c in tbs:
		#print(c.name)
		ball_position_Xs.append(c.position) #.x
		
	for c in tbs:
		remove_child(c)
	#print('no. childs',len( get_children()))
	
		
