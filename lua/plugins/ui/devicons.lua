return {
	"nvim-tree/nvim-web-devicons",
	lazy = true,
	opts = function()
		-- Common palette links (will pick up your current colorscheme)
		local function hl(name)
			return name
		end

		local by_ext = {
			-- Web
			["js"] = { icon = "", color = nil, cterm_color = nil, name = "Js" },
			["mjs"] = { icon = "", name = "Js" },
			["cjs"] = { icon = "", name = "Js" },
			["ts"] = { icon = "", name = "Ts" },
			["tsx"] = { icon = "", name = "Tsx" },
			["jsx"] = { icon = "", name = "Jsx" },
			["vue"] = { icon = "󰡄", name = "Vue" },
			["svelte"] = { icon = "", name = "Svelte" },
			["astro"] = { icon = "", name = "Astro" },
			["html"] = { icon = "", name = "Html" },
			["htm"] = { icon = "", name = "Html" },
			["css"] = { icon = "", name = "Css" },
			["scss"] = { icon = "", name = "Scss" },
			["sass"] = { icon = "", name = "Sass" },
			["less"] = { icon = "", name = "Less" },
			["pcss"] = { icon = "", name = "PostCSS" },
			["json"] = { icon = "", name = "Json" },
			["jsonc"] = { icon = "", name = "Jsonc" },
			["yaml"] = { icon = "", name = "Yaml" },
			["yml"] = { icon = "", name = "Yaml" },
			["toml"] = { icon = "", name = "Toml" },
			["md"] = { icon = "", name = "Markdown" },
			["mdx"] = { icon = "", name = "Mdx" },

			-- Backend / sys
			["py"] = { icon = "", name = "Py" },
			["pyw"] = { icon = "", name = "Py" },
			["pyi"] = { icon = "", name = "Py" },
			["rs"] = { icon = "", name = "Rust" },
			["go"] = { icon = "", name = "Go" },
			["mod"] = { icon = "", name = "GoMod" },
			["sum"] = { icon = "", name = "GoSum" },
			["lua"] = { icon = "", name = "Lua" },
			["rb"] = { icon = "", name = "Ruby" },
			["php"] = { icon = "", name = "Php" },
			["java"] = { icon = "", name = "Java" },
			["kt"] = { icon = "", name = "Kotlin" },
			["cs"] = { icon = "", name = "Csharp" },
			["cpp"] = { icon = "", name = "Cpp" },
			["cxx"] = { icon = "", name = "Cpp" },
			["cc"] = { icon = "", name = "Cpp" },
			["c"] = { icon = "", name = "C" },
			["h"] = { icon = "", name = "H" },
			["hpp"] = { icon = "", name = "Hpp" },
			["rspec"] = { icon = "", name = "Rspec" },
			["sh"] = { icon = "", name = "Sh" },
			["bash"] = { icon = "", name = "Bash" },
			["zsh"] = { icon = "", name = "Zsh" },
			["fish"] = { icon = "", name = "Fish" },

			-- Data / infra
			["sql"] = { icon = "", name = "Sql" },
			["prisma"] = { icon = "", name = "Prisma" },
			["dockerfile"] = { icon = "", name = "Dockerfile" },
			["dockerignore"] = { icon = "", name = "DockerIgnore" },
			["tf"] = { icon = "", name = "Terraform" },
			["tfvars"] = { icon = "", name = "Terraform" },
			["lock"] = { icon = "", name = "Lock" },

			-- Frontend assets
			["svg"] = { icon = "󰜡", name = "Svg" },
			["png"] = { icon = "", name = "Png" },
			["jpg"] = { icon = "", name = "Jpg" },
			["jpeg"] = { icon = "", name = "Jpeg" },
			["webp"] = { icon = "", name = "Webp" },
			["gif"] = { icon = "", name = "Gif" },

			-- Config-y things
			["env"] = { icon = "", name = "Env" },
			["editorconfig"] = { icon = "", name = "EditorConfig" },
			["conf"] = { icon = "", name = "Conf" },
			["ini"] = { icon = "", name = "Ini" },
		}

		local by_name = {
			[".gitignore"] = { icon = "", name = "GitIgnore" },
			[".gitattributes"] = { icon = "", name = "GitAttributes" },
			[".gitmodules"] = { icon = "", name = "GitModules" },
			["LICENSE"] = { icon = "", name = "License" },
			["COPYING"] = { icon = "", name = "License" },
			["Makefile"] = { icon = "", name = "Makefile" },
			["justfile"] = { icon = "", name = "Just" },
			["Dockerfile"] = { icon = "", name = "Dockerfile" },
			["docker-compose.yml"] = { icon = "", name = "DockerCompose" },
			["docker-compose.yaml"] = { icon = "", name = "DockerCompose" },
			[".env"] = { icon = "", name = "Env" },
			[".env.local"] = { icon = "", name = "Env" },
			["tsconfig.json"] = { icon = "", name = "Tsconfig" },
			["jsconfig.json"] = { icon = "", name = "Jsconfig" },
			["package.json"] = { icon = "", name = "PackageJson" },
			["package-lock.json"] = { icon = "", name = "PackageLock" },
			["pnpm-lock.yaml"] = { icon = "", name = "PnpmLock" },
			["yarn.lock"] = { icon = "", name = "YarnLock" },
			[".prettierrc"] = { icon = "", name = "Prettier" },
			[".prettierignore"] = { icon = "", name = "Prettier" },
			[".eslintrc"] = { icon = "", name = "Eslint" },
			[".eslintrc.js"] = { icon = "", name = "Eslint" },
			[".eslintrc.cjs"] = { icon = "", name = "Eslint" },
			[".eslintrc.json"] = { icon = "", name = "Eslint" },
			[".stylelintrc"] = { icon = "", name = "Stylelint" },
			[".editorconfig"] = { icon = "", name = "EditorConfig" },
		}

		return {
			default = true,
			color_icons = true,
			override_by_extension = by_ext,
			override_by_filename = by_name,
			override_by_operating_system = {},
			-- Optional: link icon highlights to something from your theme
			override = {
				DevIconLua = { link = hl("Special") },
				DevIconRs = { link = hl("Type") },
				DevIconGo = { link = hl("Function") },
			},
		}
	end,
	config = function(_, opts)
		require("nvim-web-devicons").setup(opts)

		-- If mini.icons is present, mirror a couple of mappings there too.
		local ok, mini = pcall(require, "mini.icons")
		if ok and mini.set then
			mini.setup() -- noop if already set up elsewhere
			mini.set({
				file = {
					["Dockerfile"] = { glyph = "" },
					["LICENSE"] = { glyph = "" },
				},
			})
			mini.set({
				extension = {
					ts = { glyph = "" },
					tsx = { glyph = "" },
					rs = { glyph = "" },
					go = { glyph = "" },
					lua = { glyph = "" },
					py = { glyph = "" },
					astro = { glyph = "" },
					svelte = { glyph = "" },
					prisma = { glyph = "" },
				},
			})
		end
	end,
}
