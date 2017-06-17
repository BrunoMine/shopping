--[[
	Mod Shopping para Minetest
	Copyright (C) 2016 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Inicializador de scripts
  ]]

-- Notificador de Inicializador
local notificar = function(msg)
	if minetest.setting_get("log_mods") then
		minetest.debug("[SHOPPING]"..msg)
	end
end

local modpath = minetest.get_modpath("shopping")

-- Variavel global
shopping = {}

-- Diretrizes

-- Item monetário
shopping.money = (minetest.setting_get("shopping_money") or "default:gold_ingot")
shopping.money_imagem = (minetest.setting_get("shopping_money_imagem") or "default_gold_ingot.png")

-- Itens a venda
shopping.itens = {}
-- Papyrus
shopping.itens["default:papyrus"] = {
qtd = tonumber(minetest.setting_get("shopping_papyrus_cost") or 60),
money = tonumber(minetest.setting_get("shopping_papyrus_receive") or 1),
imagem = "default_papyrus.png"
}
-- Cobble
shopping.itens["default:cobble"] = {
qtd = tonumber(minetest.setting_get("shopping_cobble_cost") or 99),
money = tonumber(minetest.setting_get("shopping_cobble_receive") or 1),
imagem = minetest.inventorycube("default_cobble.png", "default_cobble.png", "default_cobble.png")
}
-- Desert Cobble
shopping.itens["default:desert_cobble"] = {
qtd = tonumber(minetest.setting_get("shopping_desert_cobble_cost") or 99),
money = tonumber(minetest.setting_get("shopping_desert_cobble_receive") or 1),
imagem = minetest.inventorycube("default_desert_cobble.png", "default_desert_cobble.png", "default_desert_cobble.png")
}
-- Tree
shopping.itens["default:tree"] = {
qtd = tonumber(minetest.setting_get("shopping_tree_cost") or 25),
money = tonumber(minetest.setting_get("shopping_tree_receive") or 1),
imagem = minetest.inventorycube("default_tree_top.png", "default_tree.png", "default_tree.png")
}
-- Jungle Tree
shopping.itens["default:jungletree"] = {
qtd = tonumber(minetest.setting_get("shopping_jungletree_cost") or 25),
money = tonumber(minetest.setting_get("shopping_jungletree_receive") or 1),
imagem = minetest.inventorycube("default_jungletree_top.png", "default_jungletree.png", "default_jungletree.png")
}
-- Pine Tree
shopping.itens["default:pine_tree"] = {
qtd = tonumber(minetest.setting_get("shopping_pine_tree_cost") or 25),
money = tonumber(minetest.setting_get("shopping_pine_tree_receive") or 1),
imagem = minetest.inventorycube("default_pine_tree_top.png", "default_pine_tree.png", "default_pine_tree.png")
}
-- Acacia Tree
shopping.itens["default:acacia_tree"] = {
qtd = tonumber(minetest.setting_get("shopping_acacia_tree_cost") or 25),
money = tonumber(minetest.setting_get("shopping_acacia_tree_receive") or 1),
imagem = minetest.inventorycube("default_acacia_tree_top.png", "default_acacia_tree.png", "default_acacia_tree.png")
}
-- Aspen Tree
shopping.itens["default:aspen_tree"] = {
qtd = tonumber(minetest.setting_get("shopping_aspen_tree_cost") or 25),
money = tonumber(minetest.setting_get("shopping_aspen_tree_receive") or 1),
imagem = minetest.inventorycube("default_aspen_tree_top.png", "default_aspen_tree.png", "default_aspen_tree.png")
}
-- Steel
shopping.itens["default:steel_ingot"] = {
qtd = tonumber(minetest.setting_get("shopping_steel_cost") or 4),
money = tonumber(minetest.setting_get("shopping_steel_receive") or 1),
imagem = "default_steel_ingot.png"
}
-- Mese
shopping.itens["default:mese"] = {
qtd = tonumber(minetest.setting_get("shopping_mese_cost") or 1),
money = tonumber(minetest.setting_get("shopping_mese_receive") or 25),
imagem = minetest.inventorycube("default_mese_block.png", "default_mese_block.png", "default_mese_block.png")
}
-- Carregar scripts
notificar("Carregando scripts...")
dofile(modpath.."/trocar.lua")
dofile(modpath.."/acesso.lua")
dofile(modpath.."/papyrus.lua")
dofile(modpath.."/cobble.lua")
dofile(modpath.."/desert_cobble.lua")
dofile(modpath.."/tree.lua")
dofile(modpath.."/jungletree.lua")
dofile(modpath.."/pine_tree.lua")
dofile(modpath.."/acacia_tree.lua")
dofile(modpath.."/aspen_tree.lua")
dofile(modpath.."/steel.lua")
dofile(modpath.."/mese.lua")
notificar("OK")
