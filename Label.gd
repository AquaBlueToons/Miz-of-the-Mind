extends Label

const FALL = -10
const RISE = 10

@onready var timer = $"../Timer"
var scream = false
var ow = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "Time Left: %.f " % timer.time_left 
	
	if scream == true:
		addTime()
		scream = false
		$"../color".start()
		
	if ow == true:
		lostTime()
		ow = false
		$"../color".start()
	
func addTime():
	$"../Timer".start(timer.time_left + RISE)
	add_theme_color_override("font_color", Color("25e607"))
func lostTime():
	if timer.time_left > 0:
		$"../Timer".start(timer.time_left + FALL)
		add_theme_color_override("font_color", Color("fc0303"))


func _on_color_timeout():
	add_theme_color_override("font_color", Color("ffffff"))
