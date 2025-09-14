local gs = require 'gitsigns'

-- :h gitsigns-config
gs.setup {
  signcolumn = false,
  numhl = true,
  attach_to_untracked = true,
}

require 'gep.utils'.register_maps {
  { 'n',  '<space>gj',     gs.next_hunk },
  { 'n',  '<space>gk',     gs.prev_hunk },
  { 'n',  '<space>gs',     gs.stage_hunk },
  { 'x',  '<space>gs',     function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end },
  { 'n',  '<space>g<s-s>', gs.stage_buffer },
  { 'n',  '<space>gr',     gs.reset_hunk },
  { 'x',  '<space>gr',     function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end },
  { 'n',  '<space>g<s-r>', gs.reset_buffer },
  { 'n',  '<space>gu',     gs.undo_stage_hunk },
  { 'n',  '<space>gt',     gs.toggle_deleted },
  { 'n',  '<space>gp',     gs.preview_hunk },
  { 'n',  '<space>gb',     function() gs.blame_line { full = true } end },
  { 'n',  '<space>gB',     gs.blame },
  { 'n',  '<space>gd',     gs.diffthis },
}
