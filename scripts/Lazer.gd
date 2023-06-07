extends Node2D


var vel = 200

var PRE_EXPLOSAO = preload("res://scenas/mini_explosao.tscn")


func _ready():
	pass 
	
	
	
	
	
func _process(delta):
	
	   translate(Vector2(0 , -1) * vel * delta)
	
	


func _on_VisibilityNotifier2D_screen_exited():
	 var e = PRE_EXPLOSAO.instance()
	 get_parent().add_child(e)
	 e.global_position = global_position
	 queue_free()
	

	
	
	


func _on_area_area_entered(area):
	   queue_free()
	

