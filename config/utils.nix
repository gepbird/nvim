{
  lib,
  utils,
  ...
}:

{
  _module.args.utils = {
    lua = lib.nixvim.mkRaw;
    luaFunction = action: utils.lua "function() ${action} end";
  };
}
