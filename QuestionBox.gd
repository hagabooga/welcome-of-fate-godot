extends Panel

func button_press():
	visible = false
	

func delete_all_button_connections(obj : Object, sig : String):
	for x in $Buttons.get_children():
		for y in x.get_signal_connection_list(sig):
			x.disconnect(y.signal, y.target, y.method)
	#print(obj.name, " ", obj.get_signal_connection_list(sig))