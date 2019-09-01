extends Node2D
	
	
var holding_item : ItemHolder = null

func _process(delta):
	$Tooltip.visible = false	
	if holding_item != null and Input.is_action_just_released("use_item"):
		remove_hold_texture()
		holding_item.released()
		holding_item = null
	else:
		position = get_global_mouse_position()
		position -= $TextureRect.rect_size/2
		
func show_texture(holder : ItemHolder):
	$TextureRect.visible = true
	$TextureRect.texture = holder.find_node("ItemTexture").texture
	holding_item = holder
	
func remove_hold_texture():
	$TextureRect.visible = false
	$TextureRect.texture = null
	

func hovering_item(item : Item):
	#print(item.ming)
	if item != null:
		$Tooltip.visible = true
		$Tooltip/VBoxContainer/Ming.text = item.ming.capitalize() 
		$Tooltip/VBoxContainer/Desc.text = "%s (%s)"%[item.desc, item.type.capitalize()]
		$Tooltip/VBoxContainer/Cost.text = "Cost: $%d"%item.cost
		$Tooltip/VBoxContainer/Eff_Desc.text = item.eff_desc
		var pos = get_local_mouse_position()
		pos.y -= $Tooltip.rect_size.y
		$Tooltip.rect_position = pos

	
