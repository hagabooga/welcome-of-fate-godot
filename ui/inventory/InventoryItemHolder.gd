extends ItemHolderBase


var inventory_ui : InventoryUI

signal dropped_data

func get_drag_data(position):
#	var tr = TextureRect.new()
#	tr.texture = $ItemTexture.texture
#	set_drag_preview(tr)
	return self

func can_drop_data(position, data):
	if !get_tree().current_scene.player.can_move:
		return false
	if data.item == null or get_tree().paused:
		return false
	else:
		if item == null:
			if data.cost_money_drop:
				if inventory_ui == null or inventory_ui.cash - data.item.cost < 0:
					return false
				else:
					return true
		else:
			if !can_swap or !data.can_swap:
				if item.ming == data.item.ming and is_stackable():
					if data.cost_money_drop and inventory_ui.cash - data.item.cost < 0:
						return false
					return true
				return false
	return true
	
#	return data.item != null and (item == null or (item != null and data.can_swap or item.ming == data.item.ming)) \
#	 and ((data.cost_money_drop and inventory_ui.cash - data.item.cost >= 0) or !data.cost_money_drop)

func drop_data(position, data):
	if data.cost_money_drop:
		sound_player.play_sound(57,self,true,true)
		inventory_ui.cash -= data.item.cost
	if item == null:
		set_item(data.item, data.count)
		data.item_dropped_to_another()
	else:
		if data != self and data.item.ming == item.ming and is_stackable():
			self.count += data.count
			data.item_dropped_to_another()
			print("increment item")
		else:
			var save = [item, count]
			set_item(data.item, data.count)
			data.set_item(save[0], save[1])
			print("swap items")
	
	emit_signal("dropped_data")
	if inventory_ui  != null:
		inventory_ui.emit_signal("on_item_add", item)
	
	
func item_dropped_to_another():
	clear_holder()
	emit_signal("dropped_data")
