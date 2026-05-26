---@diagnostic disable: undefined-global
-- =============================================================================
-- keybindings.lua
-- Corrections depuis l'exemple officiel :
--   - hl.dsp.window.drag() et .resize() pour la souris
--   - boucle for pour les workspaces
--   - directions en toutes lettres ("left" pas "l")
-- =============================================================================

local mainMod = "SUPER"
local terminal = "kitty"
local rofidex = "/data/projets/rofidex"
local python = "/data/projets/rofidex/.venv/bin/python"

-- =============================================================================
-- FENÊTRE / SESSION
-- =============================================================================

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty --session ~/.dotfiles/kitty/sessions/home.kitty-session"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd('kitty -d "`hypercwd`"'))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(
	mainMod .. " + SHIFT + E",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ internal = 3, client = 3 }))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + T", hl.dsp.group.toggle())
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- =============================================================================
-- LANCEURS / APPS
-- =============================================================================

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(
	mainMod .. " + I",
	hl.dsp.exec_cmd("rofimoji --hidden-descriptions --selector-args='-theme ~/.config/rofi/emoji-theme.rasi'")
)
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("rofimark"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/rofi/scripts/wallpaper.sh"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(rofidex .. "/rofidex.sh"))
hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.exec_cmd(terminal .. " --class rofidex-capture " .. python .. " " .. rofidex .. "/capture.py")
)
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("~/.dotfiles/scripts/skitty-note.sh"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("geary"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("[float] speedcrunch"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-waybar.sh"))
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("[float] thunar"))

-- =============================================================================
-- FOCUS DES FENÊTRES DANS LE WORKSPACE
-- =============================================================================

-- Test si on est dans un layout "scrolling"
local function workspaceIsScrolling()
	return hl.get_active_workspace().tiled_layout == "scrolling"
end

-- Focus suivant le type de layout avec h/j/k/l type VIM
hl.bind(mainMod .. " + l", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("focus r"))
	else
		hl.dispatch(hl.dsp.focus({ direction = "right" }))
	end
end)

hl.bind(mainMod .. " + h", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("focus l"))
	else
		hl.dispatch(hl.dsp.focus({ direction = "left" }))
	end
end)

local function workspaceIsMonocle()
	return hl.get_active_workspace().tiled_layout == "monocle"
end

hl.bind(mainMod .. " + j", function()
	if workspaceIsMonocle() then
		hl.dispatch(hl.dsp.layout("cyclenext"))
	else
		hl.dispatch(hl.dsp.focus({ direction = "down" }))
	end
end)

hl.bind(mainMod .. " + k", function()
	if workspaceIsMonocle() then
		hl.dispatch(hl.dsp.layout("cycleprev"))
	else
		hl.dispatch(hl.dsp.focus({ direction = "up" }))
	end
end)

-- hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
-- hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
-- hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
-- hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- =============================================================================
-- DÉPLACEMENT DES FENÊTRES DANS LE WORKSPACE
-- =============================================================================

-- hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
-- hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
-- hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
-- hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))

hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + l", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("swapcol r"))
	else
		hl.dispatch(hl.dsp.window.move({ direction = "right" }))
	end
end)

hl.bind(mainMod .. " + SHIFT + h", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("swapcol l"))
	else
		hl.dispatch(hl.dsp.window.move({ direction = "left" }))
	end
end)

-- =============================================================================
-- WORKSPACES — boucle comme dans l'exemple officiel
-- code:10 = touche &  (1 sur AZERTY)
-- code:19 = touche à  (0 sur AZERTY)
-- =============================================================================

for i = 1, 10 do
	local key = "code:" .. (i + 9)
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- =============================================================================
-- SCRATCHPAD
-- =============================================================================

hl.bind(mainMod .. " + O", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.move({ workspace = "special:magic" }))

-- =============================================================================
-- SCROLL WORKSPACES
-- =============================================================================

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- =============================================================================
-- SOURIS — drag et resize (corrigé depuis l'exemple officiel)
-- =============================================================================

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- =============================================================================
-- VOLUME / LUMINOSITÉ
-- =============================================================================

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- =============================================================================
-- PLAYERCTL
-- =============================================================================

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
