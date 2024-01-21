local describe = describe
local it = it
local vim= vim

describe("AST",function ()

	it("can be required",function ()
    require("nvim-treesitter.ts_utils")
		-- require("AST")
	end)

	it("can get manual",function ()
    vim.cmd("h AST.txt")
	end)

	it("can use config",function ()
		require("AST.config")
	end)

	it("can use setup",function ()
		require("AST").setup("My setup")
	end)

	it("Other test",function ()

    local ts_utils = require("nvim-treesitter.ts_utils")
    local node = ts_utils.get_node_at_cursor()
    if node == nil then
      error("No Treesitter parser found.")
    end
		require("AST").test()

	end)

end)
