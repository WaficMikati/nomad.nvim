local options = {
  number = true,
  relativenumber = true,
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smartindent = true,
  signcolumn = 'yes',
}

for key, value in pairs(options) do
  vim.o[key] = value
end
