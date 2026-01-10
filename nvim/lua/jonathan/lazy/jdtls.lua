return {
  'mfussenegger/nvim-jdtls',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    local jdtls_setup = function()
      local jdtls_cmd = vim.fn.exepath('jdtls')

      -- If mason installed jdtls
      if jdtls_cmd == "" then
        local mason_path = vim.fn.stdpath('data') .. '/mason/bin/jdtls'
        if vim.fn.filereadable(mason_path) == 1 then
          jdtls_cmd = mason_path
        end
      end

      local config = {
        cmd = { jdtls_cmd or 'jdtls' },
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
      }
      require('jdtls').start_or_attach(config)
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = jdtls_setup
    })
  end
}
