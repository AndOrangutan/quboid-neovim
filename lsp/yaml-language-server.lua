
return {
    cmd = { 'yaml-language-server', '--stdio' },
    root_markers = { '.git' },
    filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
    settings = {
        -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
        redhat = { telemetry = { enabled = false } },
        yaml = {
            format = { enable = true }
        },
    },
}
