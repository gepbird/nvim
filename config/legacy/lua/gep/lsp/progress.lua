require 'lsp-progress'.setup {
  -- don't display the spinner
  client_format = function(client_name, _spinner, series_messages)
    return #series_messages > 0
      and ('[' .. client_name .. '] ' .. table.concat(series_messages, ', '))
      or nil
  end,
  -- remove "LSP" from the beginning of the message
  format = function(client_messages)
    return #client_messages > 0
      and table.concat(client_messages, ' ')
      or ''
  end,
}
