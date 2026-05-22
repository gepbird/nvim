let
  query =
    # scheme
    ''
      ; match the string after `utils.lua` and highlight the next string as lua
      (apply_expression
        (select_expression
          (variable_expression
            (identifier) @_utils)
          (attrpath
            (identifier) @_lua))
        [
          (indented_string_expression
            (string_fragment) @injection.content)
          (string_expression
            (string_fragment) @injection.content)
        ]
        (#lua-match? @_utils "^utils$")
        (#lua-match? @_lua "^lua$")
        (#set! injection.language "lua")
        (#set! injection.combined))

      ; match the string after `utils.luaFunction` and highlight the next string as lua
      (apply_expression
        (select_expression
          (variable_expression
            (identifier) @_utils)
          (attrpath
            (identifier) @_lua_func))
        [
          (indented_string_expression
            (string_fragment) @injection.content)
          (string_expression
            (string_fragment) @injection.content)
        ]
        (#lua-match? @_utils "^utils$")
        (#lua-match? @_lua_func "^luaFunction$")
        (#set! injection.language "lua")
        (#set! injection.combined))

      ; match the string after `extraConfigLua =`
      (binding
        (attrpath
          (identifier) @_key)
        [
          (indented_string_expression
            (string_fragment) @injection.content)
          (string_expression
            (string_fragment) @injection.content)
        ]
        (#lua-match? @_key "^extraConfigLua$")
        (#set! injection.language "lua")
        (#set! injection.combined))

      ; match the string after `extraConfigLuaPre =`
      (binding
        (attrpath
          (identifier) @_key)
        [
          (indented_string_expression
            (string_fragment) @injection.content)
          (string_expression
            (string_fragment) @injection.content)
        ]
        (#lua-match? @_key "^extraConfigLuaPre$")
        (#set! injection.language "lua")
        (#set! injection.combined))
    '';
in
{
  extraConfigLua = ''
    vim.treesitter.query.set('nix', 'injections', [[${query}]])
  '';
}
