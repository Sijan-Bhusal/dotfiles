return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#000000',
				base01 = '#000000',
				base02 = '#9c9090',
				base03 = '#9c9090',
				base04 = '#fcecec',
				base05 = '#fff8f8',
				base06 = '#fff8f8',
				base07 = '#fff8f8',
				base08 = '#ff9f9f',
				base09 = '#ff9f9f',
				base0A = '#ffffff',
				base0B = '#b9ffa5',
				base0C = '#ffffff',
				base0D = '#ffffff',
				base0E = '#ffffff',
				base0F = '#ffffff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#9c9090',
				fg = '#fff8f8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#ffffff',
				fg = '#000000',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#9c9090' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffffff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffffff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#ffffff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#ffffff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#ffffff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#b9ffa5',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#fcecec' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#fcecec' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#9c9090',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
