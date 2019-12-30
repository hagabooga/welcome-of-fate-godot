extends PickableWorldObject


func right_clicked():
	$Light2D.enabled = false
	return .right_clicked()
	