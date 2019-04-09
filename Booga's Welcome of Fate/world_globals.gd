extends Node

var month = 1
var day = 1

signal next_day

func emit_next_day():
	emit_signal("next_day")