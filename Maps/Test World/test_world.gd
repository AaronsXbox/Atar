extends Node2D

var playerNearFireAlarm = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Icon2.visible= true
	await get_tree().create_timer(2).timeout
	$Icon2.queue_free()
	$AnimationPlayer.play("Dog Escape")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playerNearFireAlarm && Input.is_action_just_pressed("ui_accept") && $Alarm.playing:
		$Player.use()
		$Alarm.stop()
		Events.alarm = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Dog Escape":
		$Player.canMove = true


func _on_exit_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Maps/Outside/outside.tscn")


func _on_fire_alarm_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		playerNearFireAlarm = true


func _on_fire_alarm_trigger_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		playerNearFireAlarm = false
