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
    "groovyls",
    "jsonls",
    "biome",
    "jdtls",
    "java_language_server",
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
    "ruby_ls",
    "vimls",
    "yamlls",
  }
})
