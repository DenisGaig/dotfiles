-- Auto-completion IA avec minuet-ai.nvim (provider Codestral, endpoint Mistral)
-- La clé API doit être dans la variable d'environnement MISTRAL_API_KEY
-- (fish : set -Ux MISTRAL_API_KEY "...", puis relancer le terminal).
-- Ne jamais écrire la clé directement dans ce fichier.

local add_on_event = require("vim-pack").add_on_event

add_on_event("InsertEnter", {
    {
        src = "milanglacier/minuet-ai.nvim",
        -- Le wrapper déduirait "minuet-ai" depuis le nom du dépôt ; le module s'appelle "minuet".
        module_name = "minuet",
        opts = {
            provider = "codestral",
            -- Modèle FIM : n_completions = nombre de requêtes envoyées
            -- par déclenchement (3 par défaut), donc 1 pour limiter le coût.
            n_completions = 1,
            -- Caractères de contexte envoyés (16000 par défaut ≈ 4000 tokens).
            context_window = 8000,
            -- Augmenter throttle/debounce réduit coûts et risques de rate limit.
            throttle = 1500,
            debounce = 600,
            request_timeout = 3,
            -- Passer à "debug" pour diagnostiquer un problème.
            notify = "warn",
            -- notify = "debug",
            virtualtext = {
                auto_trigger_ft = { "*" },
                -- auto_trigger_ignore_ft = { "markdown", "gitcommit" },
                keymap = {
                    accept = "<M-Tab>",
                    accept_line = "<M-l>",
                    next = "<M-n>",
                    prev = "<M-p>",
                    dismiss = "<M-e>",
                },
            },
            provider_options = {
                codestral = {
                    model = "codestral-latest",
                    -- Endpoint Mistral (et non codestral.mistral.ai) avec une clé Mistral
                    end_point = "https://api.mistral.ai/v1/fim/completions",
                    api_key = "MISTRAL_API_KEY", -- nom de la variable, pas la clé
                    optional = {
                        max_tokens = 256,
                        stop = { "\n\n" },
                    },
                },
            },
        },
    },
})
