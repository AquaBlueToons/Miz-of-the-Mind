extends RigidBody2D
var scrmable = true 

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite2D").play("Stressed")
func _physics_process(_delta):
	if scrmable == true:
		get_node("AnimatedSprite2D").play("Stressed")
func _input(_event):
	if Input.is_action_just_pressed("Scream"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and get_node("../../Player").isScreaming == false and scrmable == true:
				scrmable = false
				get_node("AnimatedSprite2D").play("Good")
				$Streedout.start()
				get_node("../../UI/Label").scream = true
				print("picked up")



func _on_streedout_timeout():
	scrmable = true
