class_name HitboxComponent
extends Area2D

@export var attack_damage := 10

func _init() -> void:
	area_entered.connect(_on_area_entered)
	

func _on_area_entered(area):
	if area is HurtboxComponent:
		area.take_hit(attack_damage)
		print("did " + str(attack_damage) + " damage")
