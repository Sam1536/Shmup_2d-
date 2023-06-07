extends Node2D


var opcao = 0
var blink = 0

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		opcao += 1
		
	if Input.is_action_just_pressed("ui_up"):
		opcao -= 1
		
	if opcao < 0:
		opcao = $itens.get_child_count() - 1
		
	if opcao > $itens.get_child_count() - 1: 
		opcao = 0
	
	if Input.is_action_just_pressed("ui_accept"):
		set_process(false)
		match opcao:
			0:
				$timer_blink.start()
				$start.play()
			1:
				pass
			2:
				get_tree().quit()
				
		
		
		
 $seta.global_position = $itens.get_child(opcao).global_position + Vector2(-30,-117)


func _on_timer_blink_timeout():
	blink += 1
	$itens/start.visible = not $itens/start.visible
	if blink > 10:
		get_tree().change_scene("res://scenas/scenas.tscn")
