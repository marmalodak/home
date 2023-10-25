local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "bashls",
    "pkgbuild_language_server",
    "clangd",
    "cmake",
    "neocmake",
    -- "groovyls", -- https://github.com/GroovyLanguageServer/groovy-language-server/issues/17 https://github.com/GroovyLanguageServer/groovy-language-server/issues/60
    "jsonls",
    "biome",
    "jdtls",
    -- "java_language_server",  -- https://github.com/georgewfraser/java-language-server
    "vtsls",
    "julials",
    "jqls",
    "lua_ls",
    "salt_ls",
    "marksman",
    "prosemd_lsp",
    "openscad_lsp",
    "purescriptls",
    "jedi_language_server",
    -- "ruby_ls",  -- https://www.reddit.com/r/ruby/comments/xtut45/state_of_the_ruby_language_server_lsp_ecosystem/
    "vimls",
    "yamlls",
  }
})
