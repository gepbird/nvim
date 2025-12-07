local trouble = require'trouble'
-- :h trouble.nvim-trouble-configuration
trouble.setup {
}

require 'gep.utils'.register_maps {
  { 'n', '<space><space>,', function() trouble.toggle('diagnostics') end },
}
