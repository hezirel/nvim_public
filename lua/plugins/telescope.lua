return {
	{
		"nvim-telescope/telescope.nvim",
		opts = function()
			---@diagnostic disable: lowercase-global, deprecated, redefined-local
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			-- You probably also -- Call the setup function to change the default behavior
			local telescope_custom_actions = {}

			local function open_files_in_mode(prompt_bufnr, mode)
				local picker = action_state.get_current_picker(prompt_bufnr)
				local selections = picker:get_multi_selection()
				local num_selections = #selections

				if num_selections > 1 then
					local files_to_open = {}
					for _, entry in ipairs(selections) do
						table.insert(files_to_open, entry.value)
					end

					local cmd
					if mode == "newtab" then
						cmd = "tabnew | e"
					elseif mode == "vsplit" then
						cmd = "vsplit"
					elseif mode == "split" then
						cmd = "split"
					end

					vim.cmd(cmd .. " " .. table.concat(files_to_open, " | " .. cmd .. " "))
					vim.cmd("stopinsert")
				else
					-- Handle single file selection based on mode
					local entry = action_state.get_selected_entry()
					local cmd
					if mode == "newtab" then
						cmd = "tabnew"
					elseif mode == "vsplit" then
						cmd = "vsplit"
					elseif mode == "split" then
						cmd = "split"
					else
						cmd = "edit"
					end
					vim.cmd(cmd .. " " .. entry.value)
				end
			end

			local function fzf_multi_select_newtab(prompt_bufnr)
				open_files_in_mode(prompt_bufnr, "newtab")
			end

			local function fzf_multi_select_vsplit(prompt_bufnr)
				open_files_in_mode(prompt_bufnr, "vsplit")
			end

			local function fzf_multi_select_split(prompt_bufnr)
				open_files_in_mode(prompt_bufnr, "split")
			end

			return {
				defaults = {
					winblend = 20,
					file_ignore_patterns = {
						"node_modules",
						".git/",
						"yarn.lock",
						"package-lock.json",
						"mason/bin",
						"mason/packages",
						"telescope_history",
						"*.log",
						"*.vim",
						"vendor/",
					},
					mappings = {
						i = {
							["<tab>"] = actions.toggle_selection + actions.move_selection_next,
							["<C-Up>"] = actions.cycle_history_prev,
							["<C-Down>"] = actions.cycle_history_next,
							["<C-T>"] = fzf_multi_select_newtab,
							["<C-V>"] = fzf_multi_select_vsplit,
							["<C-S>"] = fzf_multi_select_split,
							["<C-f>"] = function(prompt_bufnr)
								require("telescope.actions.generate").refine(prompt_bufnr, {
									prompt_to_prefix = true,
									sorter = false,
								})
							end,
						},
						n = {
							["<esc>"] = actions.close,
							["<tab>"] = actions.toggle_selection + actions.move_selection_next,
						},
					},
					dynamic_preview_title = true,
				},
				pickers = {
					buffers = {
						mappings = {
							i = {
								["<c-d>"] = require("telescope.actions").delete_buffer,
							},
							n = {
								["<c-d>"] = require("telescope.actions").delete_buffer,
							},
						},
					},
					live_grep_args = {
						mappings = {
							i = {
								["<C-f>"] = function(prompt_bufnr)
									require("telescope.actions.generate").refine(prompt_bufnr, {
										prompt_to_prefix = true,
										sorter = false,
									})
								end,
							},
						},
					},
					colorscheme = {
						enable_preview = true,
					},
					current_buffer_fuzzy_find = {
						i = {
							["<c-space>"] = function(prompt_bufnr)
								require("telescope.actions.generate").refine(prompt_bufnr, {
									prompt_to_prefix = true,
									sorter = false,
								})
							end,
						},
					},
					find_files = {
						hidden = true,
						follow = true,
						previewer = true,
						layout_strategy = "horizontal",
						layout_config = {
							width = 0.9,
							height = 0.9,
							preview_width = 0.9,
						},
						mappings = {
							i = {
								["<c-space>"] = function(prompt_bufnr)
									require("telescope.actions.generate").refine(prompt_bufnr, {
										prompt_to_prefix = true,
										sorter = false,
									})
								end,
							},
						},
					},
				},
				extensions = {
					themes = {
						enable_previewer = true,
						enable_live_preview = false,
						ignore = {
							"bamboo-light",
							"catppuccin-latte",
							"dawnfox",
							"dayfox",
							"github_light",
							"github_light_colorblind",
							"github_light_default",
							"github_light_high_contrast",
							"github_light_tritanopia",
							"ukraine",
							"tokyonight-day",
							"rose-pine-dawn",
							"onelight",
							"material-lighter",
							"mariana_lighter",
							"gruvbox-material",
							"kanagawa-lotus",
							"koehler",
						},
					},
					tasks = {
						theme = "ivy",
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					glyph = {
						action = function(glyph)
							-- argument glyph is a table.
							-- {name="", value="", category="", description=""}

							--vim.fn.setreg("*", glyph.value)

							-- insert glyph when picked
							vim.api.nvim_put({ glyph.value }, "c", true, true)
						end,
					},
					file_browser = {
						theme = "ivy",
						-- disables netrw and use telescope-file-browser in its place
						hijack_netrw = true,
					},
					gitmoji = {
						action = function(entry)
							local emoji = entry.value.value
							vim.ui.input({ prompt = "Scope ?" }, function(msg)
								local scope = msg
								vim.ui.input({ prompt = "Commit message " .. emoji .. " " }, function(msg)
									if not msg then
										return
									end
									local commit_message = entry.value.text
									if scope ~= "" then
										commit_message = commit_message .. "(" .. scope .. "): " .. msg
									else
										commit_message = commit_message .. ": " .. msg
									end
									vim.api.nvim_put({ commit_message }, "l", false, true)
								end)
							end)
						end,
					},
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
					docker = {
						-- These are the default values
						theme = "ivy",
						binary = "docker", -- in case you want to use podman or something
						compose_binary = "docker compose",
						buildx_binary = "docker buildx",
						machine_binary = "docker-machine",
						log_level = vim.log.levels.INFO,
						init_term = "vsplit", -- "vsplit new", "split new", ...
						-- NOTE: init_term may also be a function that receives
						-- a command, a table of env. variables and cwd as input.
						-- This is intended only for advanced use, in case you want
						-- to send the env. and command to a tmux terminal or floaterm
						-- or something other than a built in terminal.
					},
				},
			}
		end,
		dependencies = {
			"junegunn/fzf",
			"junegunn/fzf.vim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
			{
				"nvim-telescope/telescope-ui-select.nvim",
				config = function()
					require("telescope").load_extension("ui-select")
				end,
			},
			{
				"LinArcX/telescope-env.nvim",
				config = function()
					require("telescope").load_extension("env")
				end,
			},
			{
				"danielvolchek/tailiscope.nvim",
				config = function()
					require("telescope").load_extension("tailiscope")
				end,
			},
			{
				"olacin/telescope-gitmoji.nvim",
				config = function()
					require("telescope").load_extension("gitmoji")
				end,
			},
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				config = function()
					require("telescope").load_extension("live_grep_args")
				end,
			},
			{
				"xiyaowong/telescope-emoji.nvim",
				config = function()
					require("telescope").load_extension("emoji")
				end,
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
				dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
				config = function()
					require("telescope").load_extension("file_browser")
				end,
			},
			{
				"LukasPietzschmann/telescope-tabs",
				dependencies = { "nvim-telescope/telescope.nvim" },
				config = function()
					require("telescope-tabs").setup({})
				end,
			},
			{
				"lpoto/telescope-tasks.nvim",
				config = function()
					require("telescope").load_extension("tasks")
					local default = require("telescope").extensions.tasks.generators.default
					default.all()
				end,
			},
			{
				"edolphin-ydf/goimpl.nvim",
				dependencies = {
					{ "nvim-lua/plenary.nvim" },
					{ "nvim-lua/popup.nvim" },
					{ "nvim-telescope/telescope.nvim" },
					{ "nvim-treesitter/nvim-treesitter" },
				},
				config = function()
					require("telescope").load_extension("goimpl")
				end,
			},
			"nvim-telescope/telescope-symbols.nvim",
			{
				"lpoto/telescope-docker.nvim",
				config = function()
					require("telescope").load_extension("docker")
				end,
			},
			{
				"andrew-george/telescope-themes",
				config = function()
					require("telescope").load_extension("themes")
				end,
			},
		},
	},
	{ "sharkdp/fd" },
	{ "junegunn/fzf" },
	{ "junegunn/fzf.vim" },
	{ "nvim-telescope/telescope-symbols.nvim" },
	{ "olacin/telescope-gitmoji.nvim" },
	{ "olacin/telescope-cc.nvim" },
	{
		"axkirillov/easypick.nvim",
		opts = function()
			local easypick = require("easypick")
			local commits_types = [[
            << EOF
build: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
BREAKING CHANGE: introduces a breaking API change
chore: Other changes that don't modify src or test files
ci: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
deprecate: Deprecate stuff
docs: Documentation only changes
feat: A new feature
fix: (bug fix for the user, not a fix to a build script)
perf: A code change that improves performance
refactor: A code change that neither fixes a bug nor adds a feature
revert: Reverts a previous commit
security: Fix security issues
style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
test: Adding missing tests or correcting existing tests]]
			return {
				pickers = {
					{
						name = "Conventional Commit",
						command = "cat " .. commits_types .. " | awk -F':' '{print $1}' | sort | uniq",
						action = easypick.actions.nvim_command("normal I"),
					},
				},
			}
		end,
	},
	{ "ghassan0/telescope-glyph.nvim" },
	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup({
				enable_persistent_history = true,
				enable_macro_history = true,
				content_spec_column = true,
			})
			require("telescope").load_extension("neoclip")
			require("telescope").load_extension("macroscope")
		end,
		dependencies = {
			{ "kkharji/sqlite.lua", module = "sqlite" },
			-- you'll need at least one of these
			-- {'nvim-telescope/telescope.nvim'},
			-- {'ibhagwan/fzf-lua'},
		},
	},
	{
		"isak102/telescope-git-file-history.nvim",
		dependencies = { "tpope/vim-fugitive" },
	},
}
