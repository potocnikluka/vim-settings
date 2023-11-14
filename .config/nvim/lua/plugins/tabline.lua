--=============================================================================
--                                        https://github.com/lpoto/tabline.nvim
--=============================================================================

local M = {
  'lpoto/tabline.nvim',
  event = { 'BufRead', 'BufNewFile', 'BufNew' },
  opts = {
    hide_statusline = true,
  },
}
return M
