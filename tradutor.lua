--[[
	Mod shopping para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Sistema de tradução
  ]]

-- Modpath
local modpath = minetest.get_modpath("shopping")

-- Tradução intllib
shopping.intllib = {}
shopping.intllib.S, shopping.intllib.NS = dofile(modpath.."/lib/intllib.lua")

-- Configura tradutor opicional
shopping.S = shopping.intllib.S
shopping.NS = shopping.intllib.NS

--
-- Ajustes devido ao bug de tradutor ler apenas traduzir do ingles
--

-- Strings para repassar textos em ingles
local pt_to_en = {}

-- Gera arquivos de tradução shopping.*.tr
do
	local file_to_tb = function(file)
		local msgid = nil
		local msgstr = nil
		local tb = {}
		for line in io.lines(file) do
			
			-- Iniciando 'msgid'
			if string.sub(line, 1, 5) == "msgid" then
				
				-- Escrever no catalogo a anterior
				if msgid ~= nil and msgstr ~= nil then
					if msgid ~= "" then
						tb[msgid] = msgstr
					end
					msgid = nil
					msgstr = nil
				end
				
				if line == "msgid \"\"" then
					msgid = ""
				else
					msgid = string.sub(line, 8, (string.len(line)-1))
				end
				
			-- Continuando 'msgid'
			elseif string.sub(line, 1, 1) == "\"" and msgstr == nil and msgid ~= nil then
				msgid = msgid .. string.sub(line, 2, (string.len(line)-1))
			
			-- Iniciando 'msgstr'
			elseif string.sub(line, 1, 6) == "msgstr" then
			
				if line == "msgstr \"\"" then
					msgstr = ""
				else
					msgstr = string.sub(line, 9, (string.len(line)-1))
				end
			
			-- Continuando 'msgstr'
			elseif string.sub(line, 1, 1) == "\"" and msgstr ~= nil then
				msgstr = msgstr .. string.sub(line, 2, (string.len(line)-1))
			
			end
			
			
		end
		
		-- Escrever ultima
		if msgid ~= nil and msgstr ~= nil then
			if msgid ~= "" then
				tb[msgid] = msgstr
			end
			msgid = nil
			msgstr = nil
		end
		
		return tb
	end	
	
	-- Pegar strings principais en-pt para realizar as trocas
	pt_to_en = file_to_tb(modpath.."/locale/en.po")
	
	--minetest.log("error", "pt_to_en = "..dump(pt_to_en))
	
	local list = minetest.get_dir_list(modpath.."/locale")
	for _,file in ipairs(list) do
		
		if string.match(file, "~") == nil then
			
			-- Traduções ".po"
			if string.match(file, ".pot") == nil and string.match(file, ".po") then
				
				local lang_code = string.gsub(file, ".po", "")
				
				local pt_to_lang = file_to_tb(modpath.."/locale/"..file)
				
				-- tabela desejada
				local en_to_lang = {}
				for pt,en in pairs(pt_to_en) do
					en_to_lang[en] = pt_to_lang[pt]
				end
				
				-- Novo arquivo
				local new_file = "### Arquivo gerado por shopping apartir de "..file.."\n# textdomain: shopping\n"
				for en,lang in pairs(en_to_lang) do
					new_file = new_file .. en .. "=" .. lang .. "\n"
				end
				local saida = io.open(modpath.."/locale/shopping."..lang_code..".tr", "w")
				saida:write(new_file)
				io.close(saida)
				
				-- Gera arquivo com lang_code nulo para evitar mensagens de erro (bug do minetest)
				if lang_code == "en" then
					local saida2 = io.open(modpath.."/locale/shopping..tr", "w")
					saida2:write(new_file)
					io.close(saida2)
				end
			end
		end
	end
end

-- Ajuste para repassar termos em ingles
local s
if minetest.get_translator ~= nil then
	s = minetest.get_translator("shopping")
else
	s = shopping.intllib.S
end

shopping.s = function(...)
	local args = { ... }
	if pt_to_en[args[1]] ~= nil then
		return s(pt_to_en[args[1]], unpack(args, 2))
	end
	minetest.log("error", "[shopping] String "..dump(args[1]).." nao catalogada")
	return s(...)
end

-- Não troca string caso esteja trabalhando com intllib
if minetest.get_modpath("intllib") ~= nil 
	and minetest.get_translator == nil 
then
	shopping.s = s
end

shopping.S = function(...)
	local args = { ... }
	if type(args[1]) == "table" then
		local r = {}
		for n,a in ipairs(args[1]) do
			if n ~= 1 then -- Não traduz o primeiro
				table.insert(r, shopping.S(a))
			else
				table.insert(r, a)
			end
		end
		
		return shopping.s(unpack(r))
		
	elseif type(args[1]) == "string" then
		-- Não traduz caso faltem argumentos (devido strings ilustrativas)
		return shopping.s(...)
		
	else
		return args[1]
	end
end

-- Função que retorna a string inalterada para passar pela checagem
shopping.Sfake = function(s) return s end


