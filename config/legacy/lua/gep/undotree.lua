vim.g.undotree_WindowLayout = 2
vim.g.undotree_SetFocusWhenToggle = true
vim.g.undotree_ShortIndicators = true


require 'gep.utils'.register_maps {
  { 'n', '<space>u', ':UndotreeToggle<cr>' },
}
