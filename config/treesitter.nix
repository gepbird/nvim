let
  # match the string after lib.nixvim.mkRaw
  mkRawQuery =
    # scheme
    ''
      (apply_expression
        (select_expression
          (variable_expression
            (identifier) @_lib)
          (attrpath
            (identifier) @_nixvim
            .
            (identifier) @_mkRaw))
        (indented_string_expression
          (string_fragment) @injection.content)
        (#lua-match? @_lib "^lib$")
        (#lua-match? @_nixvim "^nixvim$")
        (#lua-match? @_mkRaw "^mkRaw$")
        (#set! injection.language "lua")
        (#set! injection.combined))
    '';
in
{
  extraConfigLua = ''
    vim.treesitter.query.set("nix", "injections", [[${mkRawQuery}]])
  '';
}
