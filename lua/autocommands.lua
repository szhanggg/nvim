local ts = require("nvim-treesitter")
local augroup = vim.api.nvim_create_augroup("myconfig.treesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "*" },
  callback = function(event)
    local filetype = event.match
    local lang = vim.treesitter.language.get_lang(filetype)

    local is_installed = nil
    if lang ~= nil then
      is_installed, _ = vim.treesitter.language.add(lang)
    end

    if not is_installed then
      local available_langs = ts.get_available()
      local is_available = vim.tbl_contains(available_langs, lang)

      if is_available then
        vim.notify("Installing treesitter parser for " .. lang, vim.log.levels.INFO)
        ts.install({ lang }):wait(30 * 1000)
      end
    end

    local ok, _ = pcall(vim.treesitter.start, event.buf, lang)
    if not ok then return end

    vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end
})

local function PackChanged(event)
  local after = event.data.spec.data and event.data.spec.data.after
  if not after then
    return false
  end

  local pkg_name = event.data.spec.name
  local function wait()
    package.loaded[pkg_name] = nil
    local ok = pcall(require, pkg_name)

    if ok then
      if type(after) == "string" then
        vim.cmd(after)
      elseif type(after) == "function" then
        after()
      end
    else
      vim.defer_fn(wait, 50)
    end
  end

  wait()

  return false
end

vim.api.nvim_create_autocmd("PackChanged", { callback = PackChanged })


