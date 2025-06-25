{
  # disable changing indentation by ftplugins
  globals = {
    rust_recommended_style = false;
    markdown_recommended_style = false;
  };

  opts = {
    backup = false; # creates a backup file
    clipboard = "unnamedplus"; # allows neovim to access the system clipboard
    cmdheight = 1; # more space in the neovim command line for displaying messages
    conceallevel = 0; # so that `` is visible in markdown files
    fileencoding = "utf-8"; # the encoding written to a file
    hlsearch = true; # highlight all matches on previous search pattern
    ignorecase = true; # ignore case in search patterns
    mouse = "a"; # allow the mouse to be used in neovim
    pumheight = 10; # pop up menu height
    showmode = false; # we don"t need to see things like -- INSERT -- anymore
    showtabline = 2; # always show tabs
    smartcase = true; # smart case
    smartindent = true; # make indenting smarter again
    splitbelow = true; # force all horizontal splits to go below current window
    splitright = true; # force all vertical splits to go to the right of current window
    swapfile = false; # creates a swapfile
    termguicolors = true; # set term gui colors (most terminals support this)
    timeoutlen = 1000; # time to wait for a mapped sequence to complete (in milliseconds)
    ttimeoutlen = 5; # process <esc> almost immediately
    undofile = true; # enable persistent undo
    updatetime = 300; # faster completion (4000ms default)
    writebackup = false; # if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true; # convert tabs to spaces
    shiftwidth = 2; # the number of spaces inserted for each indentation
    tabstop = 2; # insert 2 spaces for a tab
    cursorline = false; # highlight the current line
    number = true; # set numbered lines
    relativenumber = false; # set relative numbered lines
    numberwidth = 4; # set number column width to 2 {default 4}
    signcolumn = "yes"; # always show the sign column, otherwise it would shift the text each time
    #wrap = false;                            # display lines as one long line
    scrolloff = 8; # always see the first/last x lines
    sidescrolloff = 8; # always see the first/last x columns
    listchars = "space:·,tab:  󰌒,eol:󰌑"; # define whitespace rendering
    list = true; # enable whitespace rendering
    wrap = true; # break up long lines
    breakindent = true; # indent wrapped lines better
    showbreak = ""; # character used to indicate broken up lines
    redrawtime = 200; # turn off syntax highlighting when it gets too laggy
    display = "uhex"; # display non-printable characters as hex
  };

  # TODO: nixvim
  extraConfigLua = ''
      vim.opt.shortmess:append 'c'                    -- turn off common vim messages
      vim.opt.iskeyword:append '-'                    -- what characters count as a word movement

    -- this breaks indentation for example here:
    --[[
    ```nix
    {
      foo, # press `o` here
        |
    }:
    null
    ```
    --]]
    -- disable bad indent for comments by disabling smartindent and re-enabling most of its features
    --vim.o.smartindent = false
    --vim.o.cindent = true
    --vim.o.cinkeys:remove '0#'
    --vim.o.indentkeys:remove '0#'
  '';
}
