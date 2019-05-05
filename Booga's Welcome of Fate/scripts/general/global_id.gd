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
	"energy" : 15
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
	15:"energy"}

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