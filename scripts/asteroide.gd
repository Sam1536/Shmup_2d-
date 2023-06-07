extends Node2D


var chosen = 0
var hp = 0


onready var velY = rand_range(30, 100)
onready var velX = rand_range(-50, 50)
var knock_back = 0 

signal destroled(node)

var hps = [
	2 ,
	2 ,
	4 , 
	3 , 
	3 
	
]
	



func _ready():
	 randomize()
	 
	 for a in $asteroides.get_children():  
		 a.visible = false
	 
	 if not chosen:
		 chosen = (randi()% $asteroides.get_child_count()) + 1
		
		hp = hps[chosen - 1]
	
	 var node = get_node("asteroides/Asteroid-" + str(chosen))
	 
	 node.visible = true
	 
	 $area/shape.shape.radius = node.texture.get_width() / 2
	



func _process(delta):
	translate(Vector2(velX, velY - knock_back)  * delta)
	
	if global_position.x  > 200:
		global_position.x  = -40
	if global_position.x  < -40:
		global_position.x  = 200
		
	if global_position.y  > 300:
		global_position.y  - 60
	   
	if knock_back:
		knock_back = lerp(knock_back , 0 , .1)


func _on_area_area_entered(area):
	hp -= 1
	knock_back = 100
	if not hp:
	  destroy()
	else: 
		get_tree().call_group("camera" , "treme" , 1)
		
func destroy():
	 get_tree().call_group("camera" , "treme" , 1)
	 emit_signal("destroled" , self)
	 queue_free()

func get_hp_inicial():
	return hps[chosen -1]
