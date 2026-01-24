{
  lib,
  ...
}:

{
  plugins.codecompanion = {
    enable = true;
    settings = {
      opts.log_level = "TRACE";
      adapters = {
        http = {
          openrouter = lib.nixvim.mkRaw ''
            function()
              return require("codecompanion.adapters").extend("openai", {
                url = "https://openrouter.ai/api/v1/chat/completions",
                opts = {
                  tools = true,
                },
                env = {
                  api_key = "OPENROUTER_API_KEY",
                },
                headers = {
                  ["HTTP-Referer"] = "https://github.com/olimorris/codecompanion.nvim",
                  ["X-Title"] = "CodeCompanion",
                },
                schema = {
                  model = {
                    default = "google/gemini-3-pro-preview",
                    choices = {
                      "google/gemini-3-pro-preview",
                      "google/gemini-3-flash-preview",
                      "openai/gpt-5.2-codex",
                      "openai/gpt-4o-mini",
                      "x-ai/grok-code-fast-1",
                      "anthropic/claude-sonnet-4.5",
                      "anthropic/claude-opus-4.5",
                      "minimax/minimax-m2.1",
                    },
                  },
                },
              })
            end
          '';
        };
      };
      interactions = {
        chat = {
          adapter = "gemini";
        };
        inline = {
          adapter = "gemini";
        };
      };
    };
  };

  keymaps =
    let
      wrapLuaFunction = action: "function() ${action} end";
      cc = action: lib.nixvim.mkRaw (wrapLuaFunction "require('codecompanion').${action}");
    in
    [
      {
        mode = "n";
        key = "<space>ac";
        action = cc "toggle()";
      }
      {
        mode = "n";
        key = "<space>at";
        action = cc "actions()";
      }
    ];
}
