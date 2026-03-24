{
  lib,
  ...
}:

{
  plugins.codecompanion = {
    enable = true;
    settings = {
      opts.log_level = "INFO";
      adapters = {
        http = {
          openrouter = lib.nixvim.mkRaw ''
            function()
              return require("codecompanion.adapters").extend("openai", {
                name = "openrouter",
                formatted_name = "OpenRouter",
                url = "https://openrouter.ai/api/v1/chat/completions",
                env = {
                  api_key = "OPENROUTER_API_KEY",
                },
                headers = {
                  ["HTTP-Referer"] = "https://github.com/olimorris/codecompanion.nvim",
                  ["X-Title"] = "CodeCompanion",
                },
                schema = {
                  model = {
                    default = "moonshotai/kimi-k2.5",
                    choices = {
                      "google/gemini-3.1-pro-preview",
                      "google/gemini-3.1-flash-lite-preview",
                      "openai/gpt-5.2-codex",
                      "openai/gpt-4o-mini",
                      "x-ai/grok-code-fast-1",
                      "anthropic/claude-sonnet-4.5",
                      "anthropic/claude-opus-4.5",
                      "minimax/minimax-m2.1",
                      "moonshotai/kimi-k2.5",
                      "z-ai/glm-5",
                    },
                  },
                },
              })
            end
          '';
          llama-cpp = lib.nixvim.mkRaw ''
            function()
              return require("codecompanion.adapters").extend("openai", {
                name = "llama-cpp",
                formatted_name = "llama.cpp",
                url = "http://localhost:8080/v1/chat/completions",
                schema = {
                  model = {
                    -- there's only one model loaded into llama-cpp which will be used
                    -- but codecompanion needs a default model set, otherwise it will send model list requests which will fail
                    default = "dummy",
                    choices = { "dummy" },
                  },
                },
                -- fix tool use by merging system prompts
                -- taken from https://github.com/olimorris/codecompanion.nvim/discussions/2827#discussioncomment-15967693
                handlers = {
                  form_messages = function(self, messages)
                    local system_content = {}
                    local other_messages = {}
                    -- 1. Separate system messages from everything else
                    for _, msg in ipairs(messages) do
                      if msg.role == "system" then
                        table.insert(system_content, msg.content)
                      else
                        table.insert(other_messages, msg)
                      end
                    end
                    local final_messages = {}
                    -- 2. If there are system messages, merge them into ONE message at the top
                    if #system_content > 0 then
                      table.insert(final_messages, {
                        role = "system",
                        content = table.concat(system_content, "\n\n"),
                      })
                    end
                    -- 3. Append all the user/assistant messages
                    for _, msg in ipairs(other_messages) do
                      table.insert(final_messages, msg)
                    end
                    -- 4. Pass the cleaned messages to the standard OpenAI handler
                    local openai = require "codecompanion.adapters.http.openai"
                    return openai.handlers.form_messages(self, final_messages)
                  end,
                  parse_message_meta = function(self, data)
                    local extra = data.extra
                    if extra and extra.reasoning_content then
                      data.output.reasoning = { content = extra.reasoning_content }
                      if data.output.content == "" then
                        data.output.content = nil
                      end
                    end
                    return data
                  end,
                },
              })
            end
          '';
        };
      };
      interactions = {
        chat = {
          adapter = "openrouter";
        };
        inline = {
          adapter = "openrouter";
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
