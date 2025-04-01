local M = {}
local opts = {}

local last_layout = nil

--- Функция разбиения строки по пробелам (аналог split)
local function split_by_spaces(str)
	if not str then
		return {}
	end
	local parts = {}
	for part in (str .. " "):gmatch("%S+") do -- [[2]]
		table.insert(parts, part)
	end
	return parts
end

local function get_current_layout()
	local ok, result = pcall(function()
		return vim.system(opts.cmd_get_full, { text = true }):wait()
	end)

	if not ok then
		error(
			"Не удалось выполнить команду: "
				.. opts.cmd_get_full[1]
				.. " "
				.. table.concat(opts.cmd_get_full, " ")
		)
	end

	local current_layout = vim.trim(result.stdout)
	if current_layout == "" then
		error(
			"Не удалось получить текущую раскладку. Убедитесь, что команда "
				.. table.concat(opts.cmd_get_full, " ")
				.. " работает."
		)
	end
	return current_layout
end

local function execute_silent(target_layout)
	local full_cmd = { unpack(opts.cmd_set_full) }
	table.insert(full_cmd, target_layout)

	local ok, result = pcall(function()
		return vim.system(full_cmd, { text = true }):wait()
	end)

	if not ok then
		print("Ошибка выполнения команды: " .. result)
	else
		if result.stdout ~= "" or result.stderr ~= "" then
			print("Ошибка: " .. result.stdout .. result.stderr)
		end
	end
end

--- Инициализация плагина
function M.init(config)
	opts = config or {} -- Применяем пользовательские настройки

	-- Разбиваем все аргументы по пробелам при старте
	opts.cmd_get_layout = split_by_spaces(opts.cmd_get_layout)
	opts.args_get_layout = split_by_spaces(opts.args_get_layout)
	opts.cmd_set_layout = split_by_spaces(opts.cmd_set_layout)
	opts.args_set_layout = split_by_spaces(opts.args_set_layout)

	-- Создаём полные команды для быстрого доступа
	opts.cmd_get_full = {
		unpack(opts.cmd_get_layout),
		unpack(opts.args_get_layout),
	} -- Полная команда для получения раскладки

	opts.cmd_set_full = {
		unpack(opts.cmd_set_layout),
		unpack(opts.args_set_layout),
	} -- Базовая часть команды для изменения раскладки

	-- При входе в режим вставки:
	vim.api.nvim_create_autocmd("InsertEnter", {
		callback = function()
			local current_layout = get_current_layout()
			if last_layout and last_layout ~= current_layout then
				execute_silent(last_layout)
			end
		end,
	})

	-- При выходе из режима вставки:
	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			last_layout = get_current_layout()
			-- Переключаемся на EN или пользовательскую раскладку
			execute_silent(opts.default_layout_on_leave)
		end,
	})
end

return M
