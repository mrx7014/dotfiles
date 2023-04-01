-- Attach to certain Filetypes, add special configuration for `html`
-- Use `background` for everything else.
require 'colorizer'.setup {
  filetypes = {
    'css',
    'javascript',
    html = { mode = 'foreground'; }
  },
}
