--[[
	Mod Shopping para Minetest
	Memor v1.2 Copyright (C) 2016 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Mostruario de venda de desert_cobble (pedregulho do deserto)
  ]]

-- Node decorativo
minetest.register_node("shopping:bancada_desert_cobble_decor", {
	-- Geral
	description = "Pedras Decorativas (Bancada de Vendas)",
	
	-- Arte
	tiles = {"default_desert_cobble.png"},
	drawtype = "mesh",
	mesh = "shopping_bancada_cobble_cubos.obj",
	collision_box = {
		type = "fixed",
		fixed = {
			{0, 0, 0, 0, 0, 0},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{0, 0, 0, 0, 0, 0},
		},
	},
	
	-- Características
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = {oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	drop = "",
	
	-- Chamadas de eventos
	
	-- Verifica se tem pedra em baixo
	on_construct = function(pos)
		if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name ~= "shopping:bancada_desert_cobble" then
			minetest.remove_node(pos)
		end 
	end
	
})

-- Node Principal
minetest.register_node("shopping:bancada_desert_cobble", {
	-- Geral
	description = "Bancada de Venda de Pedregulhos do Deserto",
	
	-- Arte
	tiles = {"shopping_bancada_cobble.png"},
	drawtype = "mesh",
	mesh = "shopping_bancada_cobble.obj",
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
		shopping.acesso(player, "default:desert_cobble")
	end,
	
	-- Coloca as pedras (decorativo)
	on_construct = function(pos)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" then
			minetest.set_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="shopping:bancada_desert_cobble_decor", param2=minetest.get_node(pos).param2})
		end 
	end,
	
	-- Remove as pedras (decorativo)
	on_destruct = function(pos)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "shopping:bancada_desert_cobble_decor" then
			minetest.remove_node({x=pos.x, y=pos.y+1, z=pos.z})
		end 
	end
	
})
