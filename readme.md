# 🌐 **Autoswitcher.nvim**

**Автоматическое переключение раскладки клавиатуры при входе/выходе из режима вставки в Neovim**

---

## 📖 Описание плагина

Этот плагин позволяет автоматически переключать раскладку клавиатуры при входе и выходе из режима вставки в Neovim.  
**Особенности**:

- Использует утилиту `xkb-switch` для работы с раскладками.
- Настройка дефолтной раскладки при выходе из вставки.
- Совместимость с Linux/macOS/Windows (через WSL).

---

## 📦 Установка плагина

### **Packer**

Добавьте в конфиг Neovim (`init.lua`):

```lua
require('packer').startup(function()
  use {
    'M4dPac/autoswitcher.nvim',
    config = function()
      require('autoswitcher').setup()
    end
  }
end)
```

### **Lazy**

```lua
require('lazy').setup({
  {
    'M4dPac/autoswitcher.nvim',
    config = function()
      require('autoswitcher').setup()
    end
  }
})
```

### **Vim-Plug**

Добавьте в `init.vim`:

```vim
Plug 'M4dPac/autoswitcher.nvim'
```

Инициализация:

```lua
-- В init.lua
require('autoswitcher').setup()
```

### **Вручную**

1. Скачайте репозиторий:

```bash
git clone https://github.com/M4dPac/autoswitcher.nvim ~/.config/nvim/plugin/
```

2. Добавьте в `init.lua`:

```lua
require('autoswitcher').setup()
```

---

## 🌍 Установка xkb-switch

### **Linux**

#### Debian/Ubuntu:

```bash
sudo apt install xkb-switch  #
```

#### Arch:

```bash
sudo pacman -S xkb-switch
```

### **macOS (via Homebrew)**

```bash
brew install xkb-switch  #
```

### **Windows (WSL)**

```bash
sudo apt install xkb-switch  # В WSL
```

**В PowerShell (не WSL)**:  
Утилита не поддерживается, используйте альтернативные способы переключения раскладки.

---

## 🎯 Примеры использования

### **Сценарий 1: Автоматическое переключение**

По умолчанию плагин переключает раскладку на `us` при выходе из вставки.  
**Конфигурация**:

```lua
require('autoswitcher').setup({
  default_layout_on_leave = 'ru',  -- Измените на нужную раскладку
})
```

### **Сценарий 2: Персонализация команд**

Настройте пользовательскую команду для изменения раскладки:

```lua
require('autoswitcher').setup({
  cmd_set_layout = "setxkbmap",  -- Для Linux
  args_set_layout = "-layout",
})
```

---

## 🛠️ Поддержка и обратная связь

- **Вопросы**: Создайте issue в репозитории с описанием проблемы.
- **Баг-репорты**: Укажите:
  1. Версию Neovim (`:version`).
  2. Операционную систему.
  3. Логи ошибок (см. `:messages`).
- **Связь**: GitHub: [M4dPac/autoswitcher.nvim](https://github.com/M4dPac/autoswitcher.nvim).

---

## 🛠️ Troubleshooting

### **Ошибка: "Не найдена команда xkb-switch"**

- **Причина**: Утилита не установлена.
- **Решение**: Установите `xkb-switch` согласно инструкциям выше .

### **Ошибка: "Не удалось получить текущую раскладку"**

- **Причина**: Права на выполнение команды или неправильная настройка.
- **Решение**:
  1. Проверьте права через `chmod +x /путь/к/xkb-switch`.
  2. Убедитесь, что `xkb-switch` работает вручную: `xkb-switch -query`.

### **Плагин не работает в WSL**

- **Решение**: Убедитесь, что `xkb-switch` установлен в WSL и X сервер запущен.

---

## 📝 Пример конфигурации

```lua
require('autoswitcher').setup({
  -- Команда и параметры для получения раскладки
  cmd_get_layout = "xkb-switch",
  args_get_layout = "",

  -- Команда и параметры для изменения раскладки
  cmd_set_layout = "xkb-switch",
  args_set_layout = "-s",

  default_layout_on_leave = "us",  -- Раскладка при выходе из вставки
})
```

---

**Автор**: M4dPac  
**Лицензия**: MIT  
**Связь**: GitHub: [M4dPac/autoswitcher.nvim](https://github.com/M4dPac/autoswitcher.nvim)
