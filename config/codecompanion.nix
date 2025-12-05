{
  lib,
  ...
}:

{
  plugins.codecompanion = {
    enable = true;
    settings = {
      # TODO: remove after merged
      # breaking changes are coming soon that I'm fine with:
      # https://github.com/olimorris/codecompanion.nvim/pull/2439
      ignore_warnings = true;

      opts.log_level = "TRACE";
      strategies = {
        chat = {
          adapter = "openai";
        };
        inline = {
          adapter = "openai";
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
