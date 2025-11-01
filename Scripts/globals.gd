extends Node

var player_pos: Vector2 = Vector2(1075, 837)
var global_player_pos: Vector2
var player_damage: int = 10
var player_speed: int = 460
var dakimakura_count: int = 0

var number_of_enemies: int 
var enemy_pos: Vector2
var global_enemy_pos: Vector2
var current_wave: int

var dakimakura_price: int = 2
var new_gun_price: int = 8
var kabachok_price: int = 10
var energy_drink_price: int = 16

var money: int = 0
