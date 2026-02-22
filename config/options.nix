{
  # disable changing indentation by ftplugins
  globals = {
    markdown_recommended_style = false;
    rust_recommended_style = false;
  };

  opts = {
    breakindent = true;
    display = "uhex"; # unprintable characters as hex
    expandtab = true;
    ignorecase = true;
    iskeyword = [
      "-"
      "48-57" # numbers
      "_"
      "192-255"
      "@" # >255
    ];
    list = true;
    listchars = "space:·,tab:󰌒  ,eol:󰌑";
    messagesopt = "wait:0,history:10000";
    number = true;
    redrawtime = 200;
    scrolloff = 8;
    shiftwidth = 2;
    shortmess = "a";
    showbreak = "";
    showmode = false;
    sidescrolloff = 8;
    signcolumn = "yes";
    smartcase = true;
    smartindent = true;
    splitbelow = true;
    splitright = true;
    swapfile = false;
    tabstop = 2;
    ttimeoutlen = 5; # process <esc> quicker
    undofile = true;
    winborder = "rounded";

    # this breaks indentation for example here:
    /*
      ```nix
      {
        foo, # press `o` here
          |
      }:
      null
      ```
    */
    # disable bad indent for comments by disabling smartindent and re-enabling most of its features
    #vim.o.smartindent = false
    #vim.o.cindent = true
    #vim.o.cinkeys:remove '0#'
    #vim.o.indentkeys:remove '0#'
  };

  clipboard = {
    register = "unnamedplus";
    providers.xclip.enable = true;
  };
}
