extends Node2D
	
	
var holding_item : ItemHolderBase = null

func _process(delta):
	#print(get_global_transform_with_canvas()[2])
	$Tooltip.visible = false	
	if holding_item != null and Input.is_action_just_released("use_item"):
		remove_hold_texture()
		holding_item.released()
		holding_item = null
	else:
		position = get_global_mouse_position()
		position -= $TextureRect.rect_size/2
		
func show_texture(holder : ItemHolderBase):
	#print("LOALSD")
	#Input.set_custom_mouse_cursor(holder.get_texture(),7)
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
		if item.placeable:
			$Tooltip/VBoxContainer/Cost.text += " (Placeable)" 
		$Tooltip/VBoxContainer/Eff_Desc.text = item.eff_desc
		var s = "\n"
		if item is ToolItem:
			for x in item.stats.stats:
				var final = x.final_val
				if final != 0:
					if int(final) == final:
						s += "%s: %d\n"%[global_id.stat_idToName[x.type].capitalize(), final]
					else:	
						s += "%s: %.1f\n"%[global_id.stat_idToName[x.type].capitalize(), final]
					
		$Tooltip/VBoxContainer/Stats.text = s
		$Tooltip.rect_size.y = 150 
		if $Tooltip.rect_size.y< $Tooltip/VBoxContainer.rect_size.y:
			 $Tooltip.rect_size.y = $Tooltip/VBoxContainer.rect_size.y 
		var pos = get_local_mouse_position()
		pos.y -= $Tooltip.rect_size.y
		$Tooltip.rect_position = pos
		var tooltip_pos = $Tooltip.get_global_transform_with_canvas()[2]
		if tooltip_pos.y < 0:
			$Tooltip.rect_position.y += -tooltip_pos.y
		if tooltip_pos.x + $Tooltip.rect_size.x > get_viewport_rect().size.x:
			$Tooltip.rect_position.x -= tooltip_pos.x + $Tooltip.rect_size.x - get_viewport_rect().size.x

	
