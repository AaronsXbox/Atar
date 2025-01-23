extends Node2D
var butCheck = false
var dogFollow = false
var check = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dogFollow:
		if Input.is_action_just_pressed("ui_accept"):
			butCheck = true
			if !check:
				$Player.use()
			check = true
		if butCheck:
			$Dog.velocity.x = $Player.velocity.x
			$Dog.velocity.y = $Player.velocity.y
			var axis = Input.get_axis("ui_left","ui_right")
			if axis:
				$Dog/Dog4.play("Walk")
				$Dog/Dog4.scale.x = 0.4*axis
			else:
				$Dog/Dog4.play("Idle")
			$Dog.move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		dogFollow = true
	print(body.name,dogFollow)
		


func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player" && dogFollow:
		get_tree().change_scene_to_file("res://Maps/ReturnToHouse/House.tscn")
