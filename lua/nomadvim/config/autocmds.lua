-- Autowrite on InsertEnter, InsertLeave, and normal/visual mode changes
vim.api.nvim_create_augroup("AutoWrite", { clear = true })

vim.api.nvim_create_autocmd({ 
  "InsertLeave", 
  "InsertEnter", 
  "TextChanged", 
  "TextChangedI" 
  }, {
  group = "AutoWrite",
  callback = function()
    -- Only write if buffer is modifiable and not readonly
    if vim.bo.modifiable and not vim.bo.readonly and vim.bo.modified then
      vim.cmd("silent! write")
    end
  end,
})
