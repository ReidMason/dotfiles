return {
  cmd = { 'docker-compose-langserver', '--stdio' },
  filetypes = { 'yaml' },
  root_markers = { 'docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml' },
}
