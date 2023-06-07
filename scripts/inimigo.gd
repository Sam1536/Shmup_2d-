extends Node2D

const PRE_ASTEROIDE = preload("res://scenas/asteroide.tscn")
const PRE_explocao = preload("res://scenas/explosao.tscn" )
const PRE_CRISTAL = preload("res://scenas/cristal.tscn")



export (NodePath) var nave 


func _ready():
	restartTimer()
	pass

func _process(delta):
	pass


func _on_Timer_timeout():
	var ast = create_asteroide()
	add_child(ast)
	ast.global_position = Vector2(rand_range(40 , 120), -60)
	restartTimer()
	
	
	
func restartTimer():
	$spawn_timer.wait_time = rand_range(.5 , 3)
	$spawn_timer.start()
	
	
func on_asteroide_destroled(ast):
	if ast.chosen >= 3:
		for a in range((randi()% 2) + 2):
		   var new_ast = create_asteroide()
		   new_ast.chosen = (randi()% 2) + 1
		   add_child(new_ast) 
		   new_ast.global_position = ast.global_position
		get_tree().call_group("hud" , "asteroide_destroled" , ast)
	var e = PRE_explocao.instance()
	add_child(e)
	e.global_position = ast.global_position
	
	for a in range(ast.get_hp_inicial()):
		var c = PRE_CRISTAL.instance()
		add_child(c) 
		c.global_position = ast.global_position
		
	
func create_asteroide ():
	var ast = PRE_ASTEROIDE.instance()
	ast.connect("destroled", self, "on_asteroide_destroled")
	return ast 
	
	
	
	
