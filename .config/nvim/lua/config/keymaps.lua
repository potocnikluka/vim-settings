--=============================================================================
-------------------------------------------------------------------------------
--                                                                   REMAPPINGS
--=============================================================================
--------------------------------------------------------------- WINDOW MANAGING
-- increase the size of a window with +, decrease with -
-- resize all windows to same width with "<ctrl> + w"

vim.keymap.set("n", "+", "<cmd>vertical resize +5<CR>")
vim.keymap.set("n", "-", "<cmd>vertical resize -5<CR>")

-- Switch window with <leader>w
vim.keymap.set("n", "<leader>w", "<cmd>wincmd w<cr>")

----------------------------------------------------------------------- JUMPING
-- center cursor when jumping, jump forward with tab, backward with shift-tab
-- Navigate quickfix with <leader>k and <leader>j

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ'z")
vim.keymap.set("n", "<leader>k", "<cmd>cnext<CR>zzzv")
vim.keymap.set("n", "<leader>j", "<cmd>cprev<CR>zzzv")
vim.keymap.set("n", "<S-TAB>", "<C-O>zzzv")

--- Don't modify jumplist when jumping with { and }
vim.keymap.set(
  "n",
  "{",
  "<cmd>execute 'keepjumps norm! ' . v:count1 . '{'<CR>"
)
vim.keymap.set(
  "n",
  "}",
  "<cmd>execute 'keepjumps norm! ' . v:count1 . '}'<CR>"
)

------------------------------------------------------------- UNDO BREAK POINTS
-- start a new undo chain with punctuations

vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")

---------------------------------------------------------------------- TERMINAL
-- return to normal mode with <Esc>
-- Toggle terminal in a new tab with <C-t>

vim.keymap.set("t", "<Esc>", "<C-\\><C-N>")

----------------------------------------------------------------------- YANKING
-- Copy to external clipboard by adding <leader> prefix to yank
--
vim.keymap.set({ "v", "n" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+yg_')
vim.keymap.set("n", "<leader>yy", '"+yy')
--
-- Paste from clipboard by adding <leader> prefix to paste
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P')

for i = 1, 9 do
  vim.keymap.set("n", "<localleader>" .. i, i .. "gt")
end

---------------------------------------------------------------------- QUICKFIX
-- Toggle quickfix with <leader>q
vim.keymap.set("n", "<leader>q", function() vim.cmd("Quickfix enter") end)