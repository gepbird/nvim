local telescope = require 'telescope'
local actions = require 'telescope.actions'

telescope.setup {
  defaults = {
    prompt_prefix = ' ',
    selection_caret = ' ',
    path_display = { 'smart' },

    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<c-l>'] = actions.select_default,
        ['<c-x>'] = actions.select_horizontal,
        ['<c-v>'] = actions.select_vertical,
        ['<c-t>'] = actions.select_tab,
        ['<a-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
        ['<a-t>'] = actions.complete_tag,

        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,
        ['<c-g>'] = actions.move_to_bottom,

        ['<c-u>'] = actions.preview_scrolling_up,
        ['<c-d>'] = actions.preview_scrolling_down,

        ['<c-n>'] = actions.cycle_history_next,
        ['<c-p>'] = actions.cycle_history_prev,

        ['<tab>'] = actions.toggle_selection,
      },
    },
  },
  extensions = {
    ['ui-select'] = {
      require 'telescope.themes'.get_dropdown {},
    },
  },
}

telescope.load_extension 'ui-select'
telescope.load_extension 'fzf'
