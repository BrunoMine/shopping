--[[
	Mod Shopping para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Mostruario de venda de papyrus
  ]]

-- Tradutor de strings
local S = shopping.S

-- Node
minetest.register_node("shopping:bancada_papyrus", {
	-- Geral
	description = S("Bancada de Venda de @1", minetest.registered_items["default:papyrus"].description),
	
	-- Arte
	tiles = {"shopping_bancada_papyrus.png"},
	drawtype = "mesh",
	mesh = "shopping_bancada_papyrus.obj",
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
		shopping.acesso(player, "default:papyrus")
	end,
	
})
