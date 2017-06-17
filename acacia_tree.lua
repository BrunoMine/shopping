--[[
	Mod Shopping para Minetest
	Memor v1.2 Copyright (C) 2016 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Mostruario de venda de acacia_tree (acacia)
  ]]


-- Node
minetest.register_node("shopping:bancada_acacia_tree", {
	-- Geral
	description = "Bancada de Venda de Acacia",
	
	-- Arte
	tiles = {"shopping_bancada_acacia_tree.png"},
	drawtype = "mesh",
	mesh = "shopping_bancada_acacia_tree.obj",
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
		},
	},
	
	-- Características
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_wood_defaults(),
	
	-- Chamadas de eventos
	
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		shopping.acesso(player, "default:acacia_tree")
	end,
	
})
