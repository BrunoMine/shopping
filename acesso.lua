--[[
	Mod Shopping para Minetest
	Copyright (C) 2016 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Trocar itens
  ]]

-- Tradutor de strings
local S = shopping.S

-- Registros de itens de bancadas acessados
local online = {}

-- Metodo para exibir formspec de troca
shopping.acesso = function(player, item)
	
	if not player or not item then return end
	
	if not shopping.itens[item] then return end
	
	-- Formspec
	local formspec = "size[8,8.5]"
		..default.gui_bg
		..default.gui_bg_img
		..default.gui_slots
		.."list[current_player;main;0,4.25;8,1;]"
		.."list[current_player;main;0,5.5;8,3;8]"
		..default.get_hotbar_bg(0,4.25)
		
		.."image[0.25,0.25;4,4;"..shopping.itens[item].imagem.."]"
		.."label[3.5,0.25;"..shopping.itens[item].qtd.."]"
		
		.."image[5.5,0.25;2,2;"..shopping.money_imagem.."]"
		.."label[7.25,0.25;"..shopping.itens[item].money.."]"
		
		.."button[4,3;4,1;vender;"..S("Vender (@1)", shopping.itens[item].qtd).."]"
		
	online[player:get_player_name()] = item
	minetest.show_formspec(player:get_player_name(), "shopping:bancada", formspec)
end

-- Receber botoes
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "shopping:bancada" then 
		
		if fields.vender then
			local item = online[player:get_player_name()]
			
			if shopping.trocar(player, {item.." "..shopping.itens[item].qtd}, {shopping.money.." "..shopping.itens[item].money}) == true then
			
				-- Troca realizada
				-- Futuramente pode tocar um som (mas pode ficar muito repetitivo) [ESBOÇO]
			end	
			
		end
	end
end)

-- Remove o jogador de todas listas quando entrar no servidor
minetest.register_on_leaveplayer(function(player)
	if not player then return end
	online[player:get_player_name()] = nil
end)
