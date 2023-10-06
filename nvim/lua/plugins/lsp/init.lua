--=============================================================================
-------------------------------------------------------------------------------
--                                                                          LSP
--[[===========================================================================
A collection of LSP related plugins and configurations.

Keymaps:

  - "K"         -  Show the definition of symbol under the cursor
  - "<C-k>"     -  Show the diagnostics of the line under the cursor
  - "gd"        -  Go to the definition of symbol under cursor
  - "gr"        -  Show references to the symbol under the cursor
  - "<leader>r" -  Rename symbol under cursor

  - "<leader>f" - format the current buffer or visual selection
-----------------------------------------------------------------------------]]
local M = {}

---@param ...table|string
vim.lsp.attach = function(...)
  for _, opts in ipairs({ select(1, ...) }) do
    local ok, e = pcall(M.attach, opts)
    if not ok then
      vim.notify(e, vim.log.levels.ERROR, {
        title = "LSP",
      })
    end
  end
end

---@param opts table
vim.lsp.add_attach_condition = function(opts)
  return M.add_attach_condition(opts)
end

function M.init()
  M.set_lsp_keymaps({})
  M.set_lsp_handlers()
end

function M.set_lsp_keymaps(opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<C-k>", M.open_diagnostic_float, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)

  vim.keymap.set({ "n", "v" }, "<leader>f", vim.lsp.buf.format, opts)
end

function M.set_lsp_handlers()
  if M.handlers_set then return end
  M.handlers_set = true
  local border = "single"
  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {
      border = border,
    })
  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = border,
    })
  vim.diagnostic.config({
    float = { border = border },
    virtual_text = true,
    underline = { severity = "Error" },
    severity_sort = true,
  })
end

function M.open_diagnostic_float()
  local n, _ = vim.diagnostic.open_float()
  if not n then
    vim.notify("No diagnostics found", vim.log.levels.WARN, { title = "LSP" })
  end
end

---------------------------------------------------- lsp attach implementations

function M.attach(opts)
  if type(opts) == "string" then opts = { name = opts } end
  if type(opts) ~= "table" or type(opts.name) ~= "string" then
    error("Invalid options for attaching LSP client")
  end
  if not M.__logs then M.__logs = {} end
  vim.defer_fn(function()
    local t = M.__attach(opts)
    if type(t) ~= "table" or not next(t) then return end
    local attached = t.attached
    if type(attached) == "string" then attached = { attached } end
    if type(attached) == "table" and next(attached) then
      if M.__logs.attached == nil then M.__logs.attached = {} end
      for _, v in ipairs(attached) do
        table.insert(M.__logs.attached, v)
      end
    end
    local missing = t.missing
    if type(missing) == "string" then missing = { missing } end
    if type(missing) == "table" and next(missing) then
      if M.__logs.missing == nil then M.__logs.missing = {} end
      for _, v in ipairs(missing) do
        table.insert(M.__logs.missing, v)
      end
    end
    local non_executable = t.non_executable
    if type(non_executable) == "string" then
      non_executable = { non_executable }
    end
    if type(non_executable) == "table" and next(non_executable) then
      if M.__logs.non_executable == nil then M.__logs.non_executable = {} end
      for _, v in ipairs(non_executable) do
        table.insert(M.__logs.non_executable, v)
      end
    end
    vim.defer_fn(function()
      if not next(M.__logs) then return end
      local l = vim.log.levels.INFO
      local s = ""
      if next(M.__logs.attached or {}) then
        s = "Attached: [" .. table.concat(M.__logs.attached, ", ") .. "]"
      end
      if next(M.__logs.non_executable or {}) then
        if s:len() > 0 then s = s .. ", " end
        s = s
          .. "No executables found for: ["
          .. table.concat(M.__logs.non_executable, ", ")
          .. "]"
        l = vim.log.levels.WARN
      end
      if next(M.__logs.missing or {}) then
        if s:len() > 0 then s = s .. ", " end
        s = s
          .. "No tools found for: ["
          .. table.concat(M.__logs.missing, ", ")
          .. "]"
        l = vim.log.levels.WARN
      end
      if s:len() > 0 then vim.notify(s, l, { title = "LSP" }) end
      M.__logs = {}
    end, 100)
  end, 50)
end

function M.__attach(opts)
  opts = vim.tbl_deep_extend("force", opts or {}, vim.g[opts.name] or {})
  local buffer = opts.buffer or vim.api.nvim_get_current_buf()
  local filetype = opts.filetype
    or vim.api.nvim_buf_get_option(buffer, "filetype")

  if type(opts.name) ~= "string" then return end
  for _, o in pairs(vim.tbl_values(M.__attach_conditions or {})) do
    if type(o) == "table" and type(o.fn) == "function" then
      local f = o.fn
      local ok, v = pcall(f, opts, buffer, filetype)
      if not ok then
        vim.notify(
          "Error attaching " .. opts.name .. ": " .. v,
          vim.log.levels.WARN,
          {
            title = "LSP",
          }
        )
      end
      if
        type(v) == "table"
        and (
          type(v.missing) ~= "table"
          or not vim.tbl_contains(v.missing, opts.name)
        )
      then
        return v
      end
    end
  end
  return { missing = { opts.name } }
end

function M.add_attach_condition(opts)
  if
    type(opts) ~= "table"
    or type(opts.priority) ~= "number"
    or type(opts.fn) ~= "function"
  then
    return false
  end
  if type(M.__attach_conditions) ~= "table" then
    M.__attach_conditions = {}
  end
  table.insert(M.__attach_conditions, opts)
  table.sort(
    M.__attach_conditions,
    function(a, b) return a.priority > b.priority end
  )
  return true
end

M.init()

local cur_dir = vim.fs.dirname(debug.getinfo(1, "S").source:sub(2))
local submodules = {}

for file in vim.fs.dir(cur_dir, { depth = 1 }) do
  if type(file) == "string" and file ~= "init.lua" then
    local extension = vim.fn.fnamemodify(file, ":e")
    local tail = vim.fn.fnamemodify(file, ":r")
    if extension == "lua" then
      local ok, v = pcall(require, "plugins.lsp." .. tail)
      if ok and (type(v) == "table" or type(v) == "string") then
        table.insert(submodules, v)
      end
    end
  end
end

return submodules
