extends Node2D

func _process(_delta):
	for child in get_children():
		if child is Node2D:
			child.z_index = child.global_position.y
