return {
    'arminveres/md-pdf.nvim',
    branch = 'main',
    lazy = true,
    keys = {
        {
            "<leader>md,",
            function() require("md-pdf").convert_md_to_pdf() end,
            desc = "Markdown preview",
        },
    },
    opts = {
        toc = false,
        -- Correct: Simply return the executable name.
        -- The plugin handles the arguments and execution.
        preview_cmd = function()
            return 'zathura'
        end,
    },
    config = function(_, opts)
        require("md-pdf").setup(opts)

        -- Auto-convert on save
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = "*.md",
            callback = function()
                require("md-pdf").convert_md_to_pdf()
            end,
            desc = "Auto-convert markdown to PDF on save",
        })
    end,
}
