extends KinematicBody

const UP = Vector3(0,1,0)
const GRAVITY = 9.8

export var player_id = 0

var motion = Vector3()
var speed = 20

var lives = 3

var projectile_speed = 50

var ammo_collection_speed = 1
var ammo = 0
var max_ammo = 5
var ammo_types


func _enter_tree():
	randomize()
	ammo_types = get_parent().ammo_types
	$Timer.wait_time = ammo_collection_speed
	
func hurt(hurt_by):
	$AudioStreamPlayer3D.play()
	get_parent().update_score(hurt_by, true)

func fire():

#	var bullet = preload("res://Scenes/Ammo/Doughnut.tscn").duplicate().instance()
	var bullet = ammo_types[randi() %ammo_types.size()-1].instance()

	
	bullet.set_transform(get_global_transform().orthonormalized())
	get_parent().add_child(bullet)
	bullet.set_as_toplevel(true)
	bullet.set_linear_velocity(get_global_transform().basis[2].normalized() * projectile_speed)
	bullet.add_collision_exception_with(self) 
	bullet.fired_by = player_id


func check_lives():
	if lives == 0:
		queue_free()