class_name Utility

static func deep_copy_node(source_node : Node) -> Node:
	var new_node = source_node.duplicate()
	for property in source_node.get_property_list():
		if(property.usage == PROPERTY_USAGE_SCRIPT_VARIABLE): 
			new_node[property.name] = source_node[property.name]
	return new_node
