local status_ok, configs = pcall(require, "ts_context_commentstring")
if not status_ok then
	return
end

configs.setup({
	-- enable = true,
	enable_autocmd = false,
	--languages = {
	--   typescript = "// %s",
	--},
})
