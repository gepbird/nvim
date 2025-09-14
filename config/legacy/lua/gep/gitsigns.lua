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
  { 'nx', '<space>gs',     gs.stage_hunk },
  { 'n',  '<space>g<s-s>', gs.stage_buffer },
  { 'nx', '<space>gr',     gs.reset_hunk },
  { 'n',  '<space>g<s-r>', gs.reset_buffer },
  { 'n',  '<space>gu',     gs.undo_stage_hunk },
  { 'n',  '<space>gt',     gs.toggle_deleted },
  { 'n',  '<space>gp',     gs.preview_hunk },
  { 'n',  '<space>gb',     function() gs.blame_line { full = true } end },
  { 'n',  '<space>gB',     gs.blame },
  { 'n',  '<space>gd',     gs.diffthis },
}
