vim.o.timeout = true
vim.o.timeoutlen = 300

require('which-key').setup()

require('which-key').add({
  { '<leader>c', group = '[C]ode' },
  { '<leader>d', group = '[D]ocument' },
  { '<leader>r', group = '[R]ename' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>f', group = '[F]ZF Find' },
  { '<leader>o', group = '[O]bsidian' },
  { '<leader>w', group = '[W]orkspace' },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  { '<leader>p', group = '[P]ack' },
})

vim.keymap.set('n', '<leader>pu', function()
  vim.pack.update()
end, { desc = '[P]ack [U]pdate all' })

vim.keymap.set('n', '<leader>ps', function()
  vim.print(vim.pack.get())
end, { desc = '[P]ack [S]tatus' })

vim.keymap.set('n', '<leader>pc', function()
  vim.ui.select({ 'force', 'list_inactive', 'cancel' }, { prompt = 'Clean inactive plugins?' }, function(choice)
    if choice == 'force' then vim.pack.del({}, { force = true })
    elseif choice == 'list_inactive' then vim.pack.del({}) end
  end)
end, { desc = '[P]ack [C]lean inactive' })

vim.keymap.set('n', '<leader>pl', function()
  vim.cmd('tabedit ' .. vim.fn.stdpath('log') .. '/nvim-pack.log')
end, { desc = '[P]ack [L]og' })

vim.keymap.set('n', '<leader>?', function()
  require('which-key').show({ global = false })
end, { desc = 'Buffer Local Keymaps (which-key)' })
