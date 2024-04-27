extends CharacterBody2D


const SPEED = 800.0
const JUMP_VELOCITY = -800.0
var isScreaming = false
var ishurt = false
var jump_count = 0
var max_jump = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta):
	
	if isScreaming == false:
		
		# Add the gravity.
		if is_on_floor():
			jump_count = 0
			max_jump = 2
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle Jump.
		
		if Input.is_action_just_pressed("ui_accept") and jump_count < max_jump:
				velocity.y = JUMP_VELOCITY
				jump_count += 1
				anim.play("Jump")
				
		if ishurt == false:
			
			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions.
			var direction = Input.get_axis("ui_left", "ui_right")
			if direction == -1:
				get_node("AnimatedSprite2D").flip_h = true
			elif direction == 1:
				get_node("AnimatedSprite2D").flip_h = false
			if direction:
				velocity.x = direction * SPEED
				if velocity.y == 0:
					anim.play("Walk")
					
				if velocity.y > 0:
					anim.play("Fall")
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				if velocity.y == 0:
					anim.play("Idle")
				if velocity.y > 0:
					anim.play("Fall")
			move_and_slide()
			scream()
		elif ishurt == true:
			anim.play("Die")
	elif isScreaming == true:
		anim.play("Scream")
func scream():
	if Input.is_action_just_pressed("Scream"):
		isScreaming = true
func owwie():
	if get_node("../UI/Label").ow == true:
		ishurt = true

func _on_animation_player_animation_finished(_Scream):
	isScreaming = false


func _on_animation_player_animation_finished2(_Die):
	ishurt = false
