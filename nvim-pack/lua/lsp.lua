-- lua/lsp.lua
-- Orchestrateur LSP pour nvim-pack
-- Responsabilités :
--   1. on_attach   → keymaps et comportements à l'activation d'un serveur
--   2. diagnostics → rendu des erreurs/warnings
--   3. enable      → activation automatique des serveurs via lsp/*.lua

local diagnostic_icons = require('icons').diagnostics

-- ─────────────────────────────────────────────────────────────
-- 1. ON_ATTACH
-- Appelée automatiquement chaque fois qu'un serveur LSP
-- s'attache à un buffer.
-- ─────────────────────────────────────────────────────────────

local function on_attach(client, bufnr)

  -- Helper local : évite de répéter buffer=bufnr à chaque keymap.
  -- `opts` peut être une string (devient { desc = opts })
  -- ou une table ({ desc = '...', expr = true, ... })
  local function keymap(lhs, rhs, opts, mode)
    mode = mode or 'n'
    opts = type(opts) == 'string' and { desc = opts } or opts
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  -- Navigation entre erreurs (pas besoin de supports_method :
  -- les diagnostics sont côté Neovim, pas le serveur)
  keymap('[e', function()
    vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
  end, 'Erreur précédente')

  keymap(']e', function()
    vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
  end, 'Erreur suivante')

  keymap('[w', function()
    vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
  end, 'Warning précédent')

  keymap(']w', function()
    vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
  end, 'Warning suivant')

  -- Ouvre la fenêtre flottante de diagnostic sous le curseur
  keymap('<leader>cd', vim.diagnostic.open_float, 'Diagnostic flottant')

  -- ── Keymaps conditionnels ────────────────────────────────────
  -- Chaque keymap n'est créé que si le serveur supporte la feature.
  -- Évite des mappings silencieux qui ne font rien.

  if client:supports_method('textDocument/definition') then
    keymap('gd', vim.lsp.buf.definition, 'Aller à la définition')
  end

  if client:supports_method('textDocument/declaration') then
    keymap('gD', vim.lsp.buf.declaration, 'Aller à la déclaration')
  end

  if client:supports_method('textDocument/typeDefinition') then
    keymap('grt', function()
      require('pick.builtin').lsp_type_definitions()
    end, 'Type definitions (MiniPick)')
  end

  if client:supports_method('textDocument/implementation') then
    keymap('gri', function()
      require('pick.builtin').lsp_implementations()
    end, 'Implémentations (MiniPick)')
  end

  if client:supports_method('textDocument/references') then
    keymap('grr', function()
      require('pick.builtin').lsp_references()
    end, 'Références (MiniPick)')
  end

  if client:supports_method('textDocument/documentSymbol') then
    keymap('gO', function()
      require('pick.builtin').lsp_document_symbols()
    end, 'Symboles du document (MiniPick)')
  end

  if client:supports_method('textDocument/codeAction') then
    keymap('<leader>ca', vim.lsp.buf.code_action, 'Code actions', { 'n', 'v' })
  end

  if client:supports_method('textDocument/rename') then
    keymap('<leader>cr', vim.lsp.buf.rename, 'Renommer le symbole')
  end

  if client:supports_method('textDocument/hover') then
    keymap('K', vim.lsp.buf.hover, 'Documentation (hover)')
  end

  if client:supports_method('textDocument/signatureHelp') then
    -- En mode insertion, affiche l'aide sur la signature de la fonction
    keymap('<C-k>', vim.lsp.buf.signature_help, 'Aide sur la signature', 'i')
  end

  -- Coloration des couleurs CSS (ta feature cssls)
  if client:supports_method('textDocument/documentColor') then
    vim.lsp.document_color.enable(true, { buf = bufnr }, { style = 'virtual' })
    keymap('grc', function()
      vim.lsp.document_color.color_presentation()
    end, 'Changer le format de couleur CSS')
  end

  -- Codelens (utilisé par markdown_oxide pour les références de liens)
  if client:supports_method('textDocument/codeLens') then
    vim.api.nvim_create_autocmd(
      { 'BufEnter', 'InsertLeave', 'CursorHold' },
      {
        buffer = bufnr,
        callback = function()
          if vim.api.nvim_buf_is_loaded(bufnr) then
            vim.lsp.codelens.refresh({ bufnr = bufnr })
          end
        end,
      }
    )
    vim.lsp.codelens.refresh({ bufnr = bufnr })
  end

  -- Mise en surbrillance des références du symbole sous le curseur
  if client:supports_method('textDocument/documentHighlight') then
    local group = vim.api.nvim_create_augroup(
      'lsp_document_highlight_' .. bufnr,
      { clear = true }
    )
    vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

end

-- ─────────────────────────────────────────────────────────────
-- 2. DIAGNOSTICS
-- Configuration du rendu des erreurs/warnings.
-- S'exécute une seule fois au chargement du fichier.
-- ─────────────────────────────────────────────────────────────

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_icons.ERROR,
      [vim.diagnostic.severity.WARN]  = '󰀪',
      [vim.diagnostic.severity.HINT]  = '󰌶',
      [vim.diagnostic.severity.INFO]  = '󰋽',
    },
  },
  virtual_text = {
    prefix = '●',
    spacing = 2,
  },
  float = {
    source = 'if_many',
    border = 'rounded',
  },
  update_in_insert = false,
  severity_sort = true,
})

-- ─────────────────────────────────────────────────────────────
-- 3. BRANCHER ON_ATTACH SUR L'ÉVÉNEMENT NEOVIM
-- LspAttach est émis par Neovim chaque fois qu'un serveur
-- s'attache à un buffer.
-- ─────────────────────────────────────────────────────────────

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Configure les keymaps LSP',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end
    on_attach(client, args.buf)
  end,
})

-- ─────────────────────────────────────────────────────────────
-- 4. ACTIVER LES SERVEURS
-- Déclenché une seule fois à l'ouverture du premier fichier.
-- Lit les fichiers lsp/*.lua du runtimepath et active chaque
-- serveur dont le nom correspond.
-- ─────────────────────────────────────────────────────────────

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  once = true,
  callback = function()

    -- Injecte les capabilities de blink.cmp dans tous les serveurs.
    -- L'astérisque '*' signifie "appliquer à tous les serveurs".
    vim.lsp.config('*', {
      capabilities = require('blink.cmp').get_lsp_capabilities(nil, true),
    })

    -- Découverte automatique : cherche tous les fichiers lsp/*.lua
    -- dans le runtimepath (donc dans ton dossier nvim-pack/lsp/).
    -- fnamemodify(':t:r') extrait le nom sans extension :
    --   "~/.config/nvim-pack/lsp/lua_ls.lua" → "lua_ls"
    local servers = vim.iter(
      vim.api.nvim_get_runtime_file('lsp/*.lua', true)
    ):map(function(file)
      return vim.fn.fnamemodify(file, ':t:r')
    end):totable()

    vim.lsp.enable(servers)
  end,
})
