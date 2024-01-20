local describe = describe
local it = it
local vim= vim

describe("AST",function ()
	it("can be required",function ()
		require("AST")
	end)
	it("can get manual",function ()
    vim.cmd("h AST.txt")
	end)
	it("can use config",function ()
		require("AST.config")
	end)
end)
