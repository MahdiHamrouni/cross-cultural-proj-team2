extends Area2D


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	print("Entered")
	body.z_index = 0
	
func _on_body_exited(body):
	print("Exited")
	body.z_index = 2
		
	
