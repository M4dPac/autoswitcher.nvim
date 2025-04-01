-- Инициализация плагина
local M = {}

-- По умолчанию используем xkb-switch
local default_opts = {
	-- Команда и параметры для получения текущей раскладки
	cmd_get_layout = "xkb-switch", -- Команда
	args_get_layout = "", -- Параметры

	-- Команда и параметры для изменения раскладки
	cmd_set_layout = "xkb-switch", -- Команда
	args_set_layout = "-s", -- Параметры

	-- Команда и параметры для выполнения
	-- sh_cmd = "bash", -- Команда
	-- sh_args = "-c", -- Параметры

	-- Другие настройки
	default_layout_on_leave = "us", -- Раскладка при выходе из вставки
}

function M.setup(opts)
	opts = vim.tbl_extend("force", default_opts, opts or {})

	-- Загружаем основной код
	require("layout_switcher").init(opts)
end

return M
