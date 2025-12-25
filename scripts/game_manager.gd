extends Node


var C = 0
@onready var score: Label = %score

func _ready() -> void:
	score.text = "You have collected " + str(C) + " coins."
	
func add_point():
	C += 1
	score.text = "You have collected " + str(C) + " coins."
	print(C)
	
	
