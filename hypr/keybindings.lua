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

hl.bind(
	mainMod .. " + Return",
	hl.dsp.exec_cmd("kitty --session ~/.dotfiles/kitty/sessions/home.kitty-session"),
	{ description = "Terminal" }
)
hl.bind(
	mainMod .. " + SHIFT + Return",
	hl.dsp.exec_cmd('kitty -d "`hypercwd`"'),
	{ description = "Terminal dans le dossier courant" }
)
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), { description = "Fermer la fenêtre" })
hl.bind(
	mainMod .. " + SHIFT + E",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"),
	{ description = "Quitter Hyprland" }
)
hl.bind(
	mainMod .. " + SHIFT + F",
	hl.dsp.window.fullscreen({ internal = 3, client = 3 }),
	{ description = "Plein ecran" }
)
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.window.float({ action = "toggle" }), { description = "Fenêtre flottante" })
hl.bind(mainMod .. " + T", hl.dsp.group.toggle(), { description = "Grouper fenêtres" })
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"), { description = "Recharger la configuration" })

-- =============================================================================
-- LANCEURS / APPS
-- =============================================================================

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("~/.dotfiles/rofi/scripts/rofi-keybinds.sh"), { description = "Keybinds" })
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("rofi -show drun"), { description = "Lancer Rofi" })
hl.bind(
	mainMod .. " + I",
	hl.dsp.exec_cmd("rofimoji --hidden-descriptions --selector-args='-theme ~/.config/rofi/emoji-theme.rasi'"),
	{ description = "Emoji" }
)
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("rofimark"), { description = "Bookmark" })
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/rofi/scripts/wallpaper.sh"), { description = "Wallpaper" })
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(rofidex .. "/rofidex.sh"), { description = "Fiches RofiDEX" })
hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.exec_cmd(terminal .. " --class rofidex-capture " .. python .. " " .. rofidex .. "/capture.py"),
	{ description = "Capture RofiDEX" }
)
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("~/.dotfiles/scripts/skitty-note.sh"), { description = "Note (neovim)" })
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("geary"), { description = "Mail" })
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"), { description = "Picker de Couleur" })
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("[float] speedcrunch"), { description = "Calculatrice" })
hl.bind(
	mainMod .. " + SHIFT + B",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-waybar.sh"),
	{ description = "Toggle Waybar" }
)
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'), { description = "Screenshot" })
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("[float] thunar"), { description = "Explorateur Thunar" })
hl.bind(
	"SUPER + V",
	hl.dsp.exec_cmd(
		"bash -c 'cliphist list | head -n 30 | rofi -dmenu -display-columns 2 -theme ~/.config/rofi/cliphist.rasi | cliphist decode | wl-copy'"
	),
	{ description = "Clipboard" }
)
-- historique images, avec thumbnails
hl.bind(
	"SUPER + SHIFT + V",
	hl.dsp.exec_cmd(
		"bash -c 'rofi -modi clipboard:~/.local/bin/cliphist-rofi-img -show clipboard -show-icons -theme ~/.config/rofi/cliphist-img.rasi '"
	),
	{ description = "Clipboard pour images" }
)

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
end, { description = "Focus fenêtre à droite" })

hl.bind(mainMod .. " + h", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("focus l"))
	else
		hl.dispatch(hl.dsp.focus({ direction = "left" }))
	end
end, { description = "Focus fenêtre à gauche" })

local function workspaceIsMonocle()
	return hl.get_active_workspace().tiled_layout == "monocle"
end

hl.bind(mainMod .. " + j", function()
	if workspaceIsMonocle() then
		hl.dispatch(hl.dsp.layout("cyclenext"))
	else
		hl.dispatch(hl.dsp.focus({ direction = "down" }))
	end
end, { description = "Focus fenêtre en bas" })

hl.bind(mainMod .. " + k", function()
	if workspaceIsMonocle() then
		hl.dispatch(hl.dsp.layout("cycleprev"))
	else
		hl.dispatch(hl.dsp.focus({ direction = "up" }))
	end
end, { description = "Focus fenêtre en haut" })

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

hl.bind(
	mainMod .. " + SHIFT + k",
	hl.dsp.window.move({ direction = "up" }),
	{ description = "Déplacer la fenêtre vers le haut" }
)
hl.bind(
	mainMod .. " + SHIFT + j",
	hl.dsp.window.move({ direction = "down" }),
	{ description = "Déplacer la fenêtre vers le bas" }
)

hl.bind(mainMod .. " + SHIFT + l", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("swapcol r"))
	else
		hl.dispatch(hl.dsp.window.move({ direction = "right" }))
	end
end, { description = "Déplacer la fenêtre vers la droite" })

hl.bind(mainMod .. " + SHIFT + h", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("swapcol l"))
	else
		hl.dispatch(hl.dsp.window.move({ direction = "left" }))
	end
end, { description = "Déplacer la fenêtre vers la gauche" })

-- =============================================================================
-- REDIMENSIONNEMENT — SCROLLING LAYOUT
-- =============================================================================

-- Ajuster progressivement la largeur de la colonne active
hl.bind(mainMod .. " + CTRL + h", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("colresize -0.05"))
	end
end, { description = "Réduire la largeur de la colonne" })

hl.bind(mainMod .. " + CTRL + l", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("colresize +0.05"))
	end
end, { description = "Augmenter la largeur de la colonne" })

-- Passer aux largeurs prédéfinies
-- ALT + h/l passe entre les largeurs prédéfinies : 33,3 %, 50 %, 66,7 % et 100 % par défaut.
hl.bind(mainMod .. " + ALT + h", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("colresize -conf"))
	end
end, { description = "Largeur prédéfinie précédente" })

hl.bind(mainMod .. " + ALT + l", function()
	if workspaceIsScrolling() then
		hl.dispatch(hl.dsp.layout("colresize +conf"))
	end
end, { description = "Largeur prédéfinie suivante" })

-- =============================================================================
-- MODE "NIRI" : fenêtre seule centrée avec marges (scrolling uniquement)
-- =============================================================================

-- true = une fenêtre seule garde sa largeur de colonne (centrée, avec marges)
-- false = une fenêtre seule prend tout l'écran
-- Doit correspondre à la valeur de fullscreen_on_one_column dans hyprland.lua

local niri_mode = false
local niri_margin_v = 40 -- marge haut/bas en pixels (à ajuster)

-- Workspaces sur lesquels le mode Niri est désactivé
local niri_excluded_workspaces = {
	["3"] = true, -- Navigateur
	["5"] = true, -- Claude
	["8"] = true, -- Music
	["9"] = true, -- KeypassXC
}

local function is_niri_excluded()
	local ws = hl.get_active_workspace()
	return niri_excluded_workspaces[tostring(ws.id)] == true
end

local function apply_niri_mode()
	local active = niri_mode and not is_niri_excluded()

	hl.config({
		scrolling = {
			fullscreen_on_one_column = not active,
			focus_fit_method = active and 0 or 1,
		},
	})

	if active then
		hl.workspace_rule({
			workspace = "w[tv1]s[false]",
			gaps_out = {
				top = niri_margin_v,
				bottom = niri_margin_v,
				left = 10,
				right = 10,
			},
		})
	else
		hl.workspace_rule({
			workspace = "w[tv1]s[false]",
			gaps_out = 10,
		})
	end
end

-- apply_niri_mode()

local function update_niri_behavior()
	if not niri_mode or is_niri_excluded() then
		return
	end

	local ws = hl.get_active_workspace()
	local wins = hl.get_workspace_windows(tostring(ws.id))

	local n = 0
	for _, win in ipairs(wins) do
		if not win.floating then
			n = n + 1
		end
	end

	-- Une fenêtre : centrage Niri
	-- Plusieurs fenêtres : scrolling classique
	hl.config({
		scrolling = {
			focus_fit_method = n <= 1 and 0 or 1,
		},
	})
end

hl.on("workspace.active", function()
	apply_niri_mode()
	update_niri_behavior()
end)

hl.on("window.open", function()
	update_niri_behavior()
end)

hl.on("window.destroy", function()
	update_niri_behavior()
end)

hl.bind(mainMod .. " + G", function()
	niri_mode = not niri_mode
	apply_niri_mode()
	update_niri_behavior()

	hl.config({
		scrolling = { fullscreen_on_one_column = not niri_mode },
	})
end, { description = "Toggle fenêtre seule centrée / plein écran" })

-- =============================================================================
-- WORKSPACES — boucle comme dans l'exemple officiel
-- code:10 = touche &  (1 sur AZERTY)
-- code:19 = touche à  (0 sur AZERTY)
-- =============================================================================

for i = 1, 10 do
	local key = "code:" .. (i + 9)
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "Focus workspace " .. i })
	hl.bind(
		mainMod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = i }),
		{ description = "Move window to workspace " .. i }
	)
end

-- =============================================================================
-- SCRATCHPAD
-- =============================================================================

hl.bind(mainMod .. " + O", hl.dsp.workspace.toggle_special("magic"), { description = "Scratchpad" })
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.move({ workspace = "special:magic" }), { description = "Scratchpad" })

-- =============================================================================
-- SCROLL WORKSPACES
-- =============================================================================

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll avec souris droite" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll avec souris gauche" })

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
