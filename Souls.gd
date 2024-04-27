extends CharacterBody2D

var scrmable = true

func _ready():
	get_node("AnimatedSprite2D").play("Stressed")
	
func _physics_process(delta):
	if scrmable == true:
		get_node("AnimatedSprite2D").play("Stressed")
		

func _on_streedout_timeout():
	scrmable = true

func _on_area_2d_area_entered(area):
	if area.name == "soulDic":
		if Input.is_action_just_pressed("Scream") and get_node("../../Player").isScreaming == false:
			scrmable = false
			get_node("AnimatedSprite2D").play("Good")
			$Streedout.start()
