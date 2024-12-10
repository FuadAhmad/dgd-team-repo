extends TextureRect

var initPos
var gameplay
var isBallCallFrozen = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initPos = $frozen.position
	$frozen.visible = false
	gameplay = get_parent()
	await get_tree().create_timer(gameplay.ball_call_interval*5).timeout
	freezeBallCall()
	await get_tree().create_timer(gameplay.ball_call_interval*10).timeout
	if gameplay.is_ball_calling:
		freezeBallCall()
	
func freezeBallCall():
	if isBallCallFrozen:
		return
	isBallCallFrozen = true
	print("Freeeeeeeeeeeeeeezing ball call...")
	gameplay.set_is_ball_calling(false)
	$frozen.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property($frozen, "scale", Vector2(2,2), gameplay.ball_call_interval/5.0)
	tween.set_parallel(true)
	#tween.tween_property($frozen, "position", get_parent().get_node("BallCall").position, 2)	
	tween.tween_property($frozen, "position", $FreezeBall.position, gameplay.ball_call_interval/5.0*1.5)
	await get_tree().create_timer(gameplay.ball_call_interval*3).timeout
	UnFreezeBallCall()
	
func UnFreezeBallCall():
	if isBallCallFrozen:
		isBallCallFrozen = false
		$frozen.visible = false
		$frozen.scale = Vector2(.5,.5)
		$frozen.position = initPos
		await get_tree().create_timer(gameplay.ball_call_interval/2).timeout
		gameplay.set_is_ball_calling(true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
