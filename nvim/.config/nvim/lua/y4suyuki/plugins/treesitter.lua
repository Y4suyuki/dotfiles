require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'go', 'lua', 'python', 'rust', 'typescript', 'regex', 'c',
    'bash', 'markdown', 'sql', 'org', 'terraform',
    'html', 'css', 'javascript', 'yaml', 'json', 'toml',
  },
  highlight = { enable = true },
  indent = { enable = true },
}
