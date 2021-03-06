extends CollisionObject2D

class_name Clickable

signal clicked
signal right_clicked

var tile_pos : Vector2 setget set_tile_pos

func set_tile_pos(pos : Vector2):
	tile_pos = pos

# if clicked returns null, sdsno action occurs, allowing the player to cancel the animation
# with another click right away
func clicked(tewl : Item, user : Attributes) -> Array:
	return [ClickAction.new()]
	
func check_clicked(tewl : Item, user : Attributes):
	if tewl is ToolItem and tewl != null and user.can_use_energy(tewl.energy_cost):
		return clicked(tewl, user)

func right_clicked() -> Array:
	return [ClickAction.new()]

func is_self_adjacent(pos : Vector2) -> bool:
	var size = get_sprite_map_size()
	var current_pos = tile_pos
	#print("target pos: ", pos)
	#print(name, " pos ", tile_pos)
	for col in range(size.x):
		for row in range(size.y):
			current_pos.x += col
			current_pos.y += row
			if is_pos_adjacent(current_pos, pos):
				return true
			current_pos = tile_pos
	return false
	
func is_pos_adjacent(a : Vector2, b : Vector2) -> bool:
	return a == b or \
	(a.x == b.x and (a.y + 1 == b.y or a.y - 1 == b.y)) or \
	(a.y == b.y and (a.x + 1 == b.x or a.x - 1 == b.x)) or \
	(a.x + 1 == b.x and a.y + 1 == b.y) or \
	(a.x - 1 == b.x and a.y - 1 == b.y) or \
	(a.x + 1 == b.x and a.y - 1 == b.y) or \
	(a.x - 1 == b.x and a.y + 1 == b.y)

func get_sprite_map_size() -> Vector2:
	if $Sprite.region_enabled:
		return Vector2($Sprite.region_rect.size.x/$Sprite.hframes/32, $Sprite.region_rect.size.y/32/$Sprite.vframes)
	else:
		return Vector2($Sprite.texture.get_width()/32, $Sprite.texture.get_height()/32)
		
