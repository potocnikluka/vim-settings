--=============================================================================
-------------------------------------------------------------------------------
--                                                        TELESCOPE-DOCKER-NVIM
--[[===========================================================================
https://github.com/lpoto/telescope-docker.nvim

Handle docker containers, images and compose files from a prompt.

commands:
  :Docker {containers|images|compose} - show a list of containers,
                                       images or compose files
-----------------------------------------------------------------------------]]
local M = {
  "lpoto/telescope-docker.nvim",
  cmd = "Docker",
}

function M.command()
  vim.api.nvim_create_user_command("Docker", function(opts)
    if type(opts.args) ~= "string" then
      return
    end
    local f = "containers"
    if opts.args:match "^i" then
      f = "images"
    elseif opts.args:match "^f" then
      f = "files"
    elseif opts.args:match "^c.*m" then
      f = "compose"
    end
    Util.require("telescope", function(telescope)
      telescope.extensions.docker[f]()
    end)
  end, {
    nargs = "?",
    complete = function(c)
      local items = { "containers", "images", "compose", "files" }
      table.sort(items, function(a, b)
        return Util.string_matching_score(c, a)
          > Util.string_matching_score(c, b)
      end)
      return items
    end,
  })
end

function M.config()
  M.command()

  Util.require("telescope", function(telescope)
    telescope.setup {
      extensions = {
        docker = {
          theme = "ivy",
          log_level = vim.log.levels.INFO,
          initial_mode = "normal",
        },
      },
    }

    telescope.load_extension "docker"
  end)
end

return M