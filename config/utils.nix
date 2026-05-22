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

  extraConfigLuaPre = ''
    utils = {}
    local file_big_cache = {}
    function utils.is_file_big(buffer)
      if file_big_cache[buffer] ~= nil then
        return file_big_cache[buffer]
      end

      local max_bytes = 100 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buffer))
      local big = ok and stats and stats.size > max_bytes
      file_big_cache[buffer] = big
      return big
    end
  '';
}
