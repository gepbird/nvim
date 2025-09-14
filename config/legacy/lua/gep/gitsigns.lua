local gs = require 'gitsigns'

-- :h gitsigns-config
gs.setup {
  signcolumn = false,
  numhl = true,
  attach_to_untracked = true,
}

require 'gep.utils'.register_maps {
  { 'n',  '<space>gj',     function() gs.nav_hunk 'next' end },
  { 'n',  '<space>gk',     function() gs.nav_hunk 'prev' end },
  { 'n',  '<space>gs',     gs.stage_hunk },
  { 'x',  '<space>gs',     function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end },
  { 'n',  '<space>g<s-s>', gs.stage_buffer },
  { 'n',  '<space>gr',     gs.reset_hunk },
  { 'x',  '<space>gr',     function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end },
  { 'n',  '<space>g<s-r>', gs.reset_buffer },
  { 'n',  '<space>gp',     gs.preview_hunk_inline },
  { 'n',  '<space>g<s-p>', gs.preview_hunk },
  { 'ox', 'ih',            gs.select_hunk },
  { 'ox', 'ah',            gs.select_hunk },
  { 'n',  '<space>gb',     function() gs.blame_line { full = true } end },
  { 'n',  '<space>g<s-b>', gs.blame },
  { 'n',  '<space>gd',     gs.diffthis },
}
