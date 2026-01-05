{
  lib,
  ...
}:

{
  plugins.codecompanion = {
    enable = true;
    settings = {
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
