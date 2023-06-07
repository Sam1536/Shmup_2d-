extends Node2D

const PRE_LAZER = preload("res://scenas/Lazer.tscn")

export var vel = 60
export var vely = 60

var escudo = 100.0

onready var shape_size = $area/shape.shape.radius

onready var escudo_size = $escudo/Sprite.material.get_shader_param("size")

export (NodePath) var lezeres

#lazer.global_position = global_position + Vector2(0 , -30) lazer manual
#posição minima esquerda 20
#posição maxima direita  136
#posição maxima baixo  267
#posição maxima cima  25

func _ready():
	
	if lezeres:
		lezeres = get_node(lezeres)
	else:
		lezeres = get_parent()
	 


func _process(delta):
	var dirX = 0
	var diry = 0  
	
	if Input.is_action_pressed("ui_left"):
		dirX += -1
	
	if Input.is_action_pressed("ui_right"):
		dirX += 1
	 
	
	
	elif Input. is_action_pressed("ui_up"):
		position.y -= 1
	elif Input. is_action_pressed("ui_down"):
		position.y += 1
		
		
	if Input.is_action_just_pressed("ui_accept"):
	 if get_tree().get_nodes_in_group("lezeres").size() < 7 :
	   var lazer = PRE_LAZER.instance()
	   lezeres.add_child(lazer) 
	   lazer.global_position = $blaster.global_position
		 
	
	translate(Vector2(dirX,0) * vel * delta)
	translate(Vector2(diry,0) * vel * delta)
	
	
	
	#limite para parede esquerda,direita,cima e baixo  ⇣
	
	#if global_position.y < 20:
		#global_position.y = 136
		
	#if global_position.x > 58:
		#global_position.x = 58
	
		   # ou abaixo ⬇
		
	global_position.x = clamp(global_position.x , 20 , 136)
		
	global_position.y = clamp(global_position.y , 25 , 267)



func _on_area_area_entered(area):
	if area.get_parent().has_method("destroy"):
		 area.get_parent().destroy()
	
	if [4].find(area.collision_layer) >= 0:
	   get_tree().call_group("camera" , "treme" , 1)
	   escudo -= .35
	   var proporcao = escudo / 100.0
	   $area/shape.shape.radius = shape_size * proporcao
	   $escudo/Sprite.material.set_shader_param("size" , escudo_size * proporcao )


func _on_dead_area_area_exited(area):
	visible = false
	set_process(false)
