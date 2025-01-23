extends CharacterBody2D

@export var canMove = true
const SPEED = 10.0
const JUMP_VELOCITY = -400.0

func use():
	$Enteract.play(0)
	print("ran")
	await get_tree().create_timer(1).timeout
	$Enteract.stop()
func _physics_process(delta: float) -> void:
	if canMove:
		var dir = Input.get_vector("ui_up","ui_down","ui_left","ui_right")
		if !dir:
			$AnimatedSprite2D.play("Idle")
		if Input.is_action_pressed("ui_up"):
			velocity.y =-SPEED
			velocity.x = 0
			$AnimatedSprite2D.play("Walk")
		elif Input.is_action_pressed("ui_down"):
			velocity.y = SPEED
			velocity.x = 0
			$AnimatedSprite2D.play("Walk")
		else:
			velocity.y = 0
			
		
		if Input.is_action_pressed("ui_left"):
			velocity.x = -SPEED
			velocity.y = 0
			$AnimatedSprite2D.scale.x = -0.5
			$AnimatedSprite2D.play("Walk")
		elif Input.is_action_pressed("ui_right"):
			velocity.x = SPEED
			velocity.y = 0
			$AnimatedSprite2D.play("Walk")
			$AnimatedSprite2D.scale.x = 0.5
		else:
			velocity.x = 0
		move_and_slide()
	else:
		$AnimatedSprite2D.play("Idle")

func _on_animated_sprite_2d_animation_changed() -> void:
	if $AnimatedSprite2D.animation == "Walk" && !$Walk.playing:
		$Walk.play(0)
	if $AnimatedSprite2D.animation == "Idle" && $Walk.playing:
		$Walk.stop()
