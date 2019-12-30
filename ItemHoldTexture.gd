extends CanvasLayer
	
	
var holding_item : ItemHolderBase = null

func _process(delta):
	#print(get_global_transform_with_canvas()[2])
	$Node2D/Tooltip.visible = false	
	if holding_item != null and Input.is_action_just_released("use_item"):
		remove_hold_texture()
		holding_item.released()
		holding_item = null
	else:
		$Node2D.position = $Node2D.get_global_mouse_position()
		$Node2D.position -= $Node2D/TextureRect.rect_size/2
		
func show_texture(holder : ItemHolderBase):
	#print("LOALSD")
	#Input.set_custom_mouse_cursor(holder.get_texture(),7)
	$Node2D/TextureRect.visible = true
	$Node2D/TextureRect.texture = holder.find_node("ItemTexture").texture
	holding_item = holder
	
func remove_hold_texture():
	$Node2D/TextureRect.visible = false
	$Node2D/TextureRect.texture = null
	

func hovering_item(item : Item):
	#print(item.ming)
	if item != null:
		$Node2D/Tooltip.visible = true
		$Node2D/Tooltip/VBoxContainer/Ming.text = item.ming.capitalize() 
		$Node2D/Tooltip/VBoxContainer/Desc.text = "%s (%s)"%[item.desc, item.type.capitalize()]
		$Node2D/Tooltip/VBoxContainer/Cost.text = "Cost: $%d"%item.cost 
		if item.placeable:
			$Node2D/Tooltip/VBoxContainer/Cost.text += " (Placeable)" 
		$Node2D/Tooltip/VBoxContainer/Eff_Desc.text = item.eff_desc
		var s = "\n"
		if item is ToolItem:
			for x in item.stats.stats:
				var final = x.final_val
				if final != 0:
					if int(final) == final:
						s += "%s: %d\n"%[global_id.stat_idToName[x.type].capitalize(), final]
					else:	
						s += "%s: %.1f\n"%[global_id.stat_idToName[x.type].capitalize(), final]
					
		$Node2D/Tooltip/VBoxContainer/Stats.text = s
		$Node2D/Tooltip.rect_size.y = 150 
		if $Node2D/Tooltip.rect_size.y< $Node2D/Tooltip/VBoxContainer.rect_size.y:
			 $Node2D/Tooltip.rect_size.y = $Node2D/Tooltip/VBoxContainer.rect_size.y 
		var pos = $Node2D.get_local_mouse_position()
		pos.y -= $Node2D/Tooltip.rect_size.y
		$Node2D/Tooltip.rect_position = pos
		var tooltip_pos = $Node2D/Tooltip.get_global_transform_with_canvas()[2]
		if tooltip_pos.y < 0:
			$Node2D/Tooltip.rect_position.y += -tooltip_pos.y
		if tooltip_pos.x + $Node2D/Tooltip.rect_size.x > $Node2D.get_viewport_rect().size.x:
			$Node2D/Tooltip.rect_position.x -= tooltip_pos.x + $Node2D/Tooltip.rect_size.x - $Node2D.get_viewport_rect().size.x

	
