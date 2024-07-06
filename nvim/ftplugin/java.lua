local home = os.getenv 'HOME'
local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, 'jdtls')
if not status then
  vim.notify('jdtls not found', vim.log.levels.WARN)
  return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local config = {
  cmd = {
    '/usr/lib/jvm/java-17-openjdk-amd64/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. home .. '/.local/share/nvim/lombok.jar',
    '-jar',
    vim.fn.glob(home .. '/.local/share/nvim/mason/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    home .. '/.local/share/nvim/mason/jdtls/config_linux',
    '-data',
    workspace_dir,
  },
  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
  settings = {
    java = {
      signatureHelp = { enabled = true },
      extendedClientCapabilities = extendedClientCapabilities,
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = 'all', -- literals, all, none
        },
      },
      format = {
        enabled = false,
      },
      import = {
        version = nil,
        gradle = {
          java = {
            home = "/usr/lib/jvm/jdk-11/",
          },
          wrapper = {
            enabled = false,
          },
        }
      },
      configuration = {
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        runtimes = {
          {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/jdk-11/bin/java",
            default = true,
          },
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk-amd64/bin/java",
          },
        },
        jdt = {
          ls = {
            java = {
              -- home = "/usr/lib/jvm/java-17-openjdk-amd64/bin/java"
            },
          }
        }
      },
    },

    init_options = {
      bundles = {},
    },
  }
}
require('jdtls').start_or_attach(config)

vim.keymap.set('n', '<leader>co', "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = 'Organize Imports' })
vim.keymap.set('n', '<leader>crv', "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = 'Extract Variable' })
vim.keymap.set('v', '<leader>crv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
  { desc = 'Extract Variable' })
vim.keymap.set('n', '<leader>crc', "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = 'Extract Constant' })
vim.keymap.set('v', '<leader>crc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
  { desc = 'Extract Constant' })
vim.keymap.set('v', '<leader>crm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = 'Extract Method' })

vim.keymap.set('v', '<leader>tm', "<Esc><Cmd>lua require('jdtls').test_nearest_method()<CR>",
  { desc = 'Test Nearest Method' })
vim.keymap.set('v', '<leader>crm', "<Esc><Cmd>lua require('jdtls').test_class()<CR>", { desc = 'Test Class' })
