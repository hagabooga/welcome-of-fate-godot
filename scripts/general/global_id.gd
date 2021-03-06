extends Node

var stats_nameToid = {
	"strength" : 0,
	"intelligence" : 1,
	"agility" : 2,
	"luck" : 3,
	"physical" : 4,
	"magical" : 5,
	"armor" : 6,
	"resist" : 7,
	"hit" : 8,
	"dodge" : 9,
	"crit" : 10,
	"crit multi" : 11,
	"atk speed" : 12,
	"hp" : 13,
	"mp" : 14,
	"energy" : 15,
	"xp" : 16
}

var stat_idToColor = {
	0: Color.red,
	1: Color.blue,
	2: Color.green,
	3: Color.cyan,
	4: Color.blanchedalmond,
	5: Color.violet,
	6: Color.orangered,
	7: Color.purple,
	8: Color.greenyellow,
	9: Color.lightcoral,
	10: Color.aquamarine,
	11: Color.aqua,
	12: Color.gainsboro,
	13: Color.red,
	14: Color.blue,
	15: Color.orange,
	16: Color.yellow
}



var stat_idToName = {
	0:"strength",
	1:"intelligence",
	2:"agility",
	3:"luck",
	4:"physical",
	5:"magical",
	6:"armor",
	7:"resist",
	8:"hit",
	9:"dodge",
	10:"crit",
	11:"crit multi",
	12:"atk speed",
	13:"hp",
	14:"mp",
	15:"energy",
	16:"xp"
	}

var item_base = {
	0:"Neutral",
	1:"Consumable",
	2:"Weapon",
	3:"Armor"}


var equipment_idx = {2:3, 3:3,
	"accessory":0,"head":1,"neck":2, "body":4,
"shield":5, "boots":6,"bottom":7,"gloves":8}

var weapons = [3]

var item_type = {
	0:"Plant",
	1:"Misc.",
	2:"Tool",
	3:"Wand"}
	
var id_facing_string = {0:"up", 1:"left", 2:"down", 3:"right"}