-- Piscine boilerplate as LuaSnip snippets.
-- Loaded from lua/plugins/coding/snippets.lua. Double-quoted "\t" is a real tab,
-- which matters for both the Norm (C uses tabs) and Makefile recipe lines.

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

-- Turn the current file name into an include-guard macro, e.g. ft_printf.h -> FT_PRINTF_H
local function guard()
	local name = vim.fn.expand("%:t")
	if name == "" then
		name = "HEADER_H"
	end
	return (name:gsub("[%.%-]", "_"):upper())
end

local M = {}

M.c = {
	-- A minimal main()
	s("main", {
		t({ "int\tmain(void)", "{", "\t" }),
		i(1),
		t({ "", "\treturn (0);", "}" }),
	}),

	-- main() with args
	s("mainargs", {
		t({ "int\tmain(int argc, char **argv)", "{", "\t" }),
		i(1),
		t({ "", "\treturn (0);", "}" }),
	}),

	-- A norm-shaped function stub
	s("ftfn", {
		i(1, "int"),
		t("\tft_"),
		i(2, "name"),
		t("("),
		i(3, "void"),
		t({ ")", "{", "\t" }),
		i(4),
		t({ "", "}" }),
	}),

	-- Include guard driven by the file name
	s("guard", {
		t("#ifndef "),
		f(guard),
		t({ "", "# define " }),
		f(guard),
		t({ "", "", "" }),
		i(1),
		t({ "", "", "#endif" }),
	}),
}

M.make = {
	-- A norm-compliant 42 Makefile
	s("makefile", {
		t("NAME\t= "),
		i(1, "a.out"),
		t({ "", "", "CC\t\t= cc", "CFLAGS\t= -Wall -Wextra -Werror", "", "SRCS\t= " }),
		i(2, "main.c"),
		t({
			"",
			"OBJS\t= $(SRCS:.c=.o)",
			"",
			"all: $(NAME)",
			"",
			"$(NAME): $(OBJS)",
			"\t$(CC) $(CFLAGS) $(OBJS) -o $(NAME)",
			"",
			"%.o: %.c",
			"\t$(CC) $(CFLAGS) -c $< -o $@",
			"",
			"clean:",
			"\trm -f $(OBJS)",
			"",
			"fclean: clean",
			"\trm -f $(NAME)",
			"",
			"re: fclean all",
			"",
			".PHONY: all clean fclean re",
			"",
		}),
	}),
}

return M
