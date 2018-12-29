--[[
	Mod Shopping para Minetest
	Copyright (C) 2016 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Mostruario de venda de jungletree (arvore selvagem)
  ]]

-- Tradutor de strings
local S = shopping.S

-- Node
minetest.register_node("shopping:bancada_jungletree", {
	-- Geral
	description = S("Bancada de Venda de @1", minetest.registered_items["default:jungletree"].description),
	
	-- Arte
	tiles = {"shopping_bancada_jungletree.png"},
	drawtype = "mesh",
	mesh = "shopping_bancada_jungletree.obj",
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
		shopping.acesso(player, "default:jungletree")
	end,
	
})
