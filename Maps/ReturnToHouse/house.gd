extends Node2D
var playerNearFireAlarm = false
var playerNearKennalDoor = false
var playerNearBed = false
var dogInPlace = false
var shutDoorOnce = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Events.alarm:
		$Alarm.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if shutDoorOnce && playerNearBed:
		$Player.canMove = false
		for x in get_children():
			if x.is_class("Sprite2D"):
				x.visible = false
		$"Pixil-layer-0".visible = true
		$"Pixil-layer-1".visible = true
		$Player.visible = false
		$Label.visible = true
		shutDoorOnce = false
	if playerNearFireAlarm && Input.is_action_just_pressed("ui_accept") && $Alarm.playing:
		$Player.use()
		$Alarm.stop()
	if !dogInPlace:
		$Dog4.velocity.x = $Player.velocity.x
		$Dog4.velocity.y = $Player.velocity.y
		var axis = Input.get_axis("ui_left","ui_right")
		if axis:
			$Dog4/Dog4.play("Walk")
			$Dog4/Dog4.scale.x = 0.4*axis
		else:
			$Dog4/Dog4.play("Idle")
		$Dog4.move_and_slide()
	
	else:
		if playerNearKennalDoor && Input.is_action_just_pressed("ui_accept") && !shutDoorOnce:
			$Door.play("Closed")
			$Player.use()
			shutDoorOnce = true
			


func _on_fire_alarm_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		playerNearFireAlarm = true


func _on_fire_alarm_trigger_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		playerNearFireAlarm = false


func _on_dog_in_crate_checker_body_entered(body: Node2D) -> void:
	if body.name == "Dog4":
		$Dog4.visible = false
		$PropDog4.visible = true
		dogInPlace = true
		


func _on_dog_kennal_door_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		playerNearKennalDoor = true

func _on_dog_kennal_door_trigger_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		playerNearKennalDoor = false


func _on_bed_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		playerNearBed = true


func _on_bed_trigger_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		playerNearBed = false
