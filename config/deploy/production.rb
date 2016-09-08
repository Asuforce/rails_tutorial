%w(app_b01 app_b02).each do |host|
  server host,
    user: 'rails',
    roles: %w(app db web),
    ssh_options: {
      keys: %w(~/.ssh/id_ed25519),
      forward_agent: true,
      auth_methods: %w(publickey),
      proxy: Net::SSH::Proxy::Command.new('ssh -oStrictHostKeyChecking=no -i ~/.ssh/id_ed25519 rails@bastion.asuforce.xyz -W %h:%p')
    }
end

server "revproxy_b01",
  user: "revproxy",
  roles: :revproxy, no_release: true,
    ssh_options: {
      keys: %w(~/.ssh/id_ed25519),
      forward_agent: true,
      auth_methods: %w(publickey),
      proxy: Net::SSH::Proxy::Command.new('ssh -oStrictHostKeyChecking=no -i ~/.ssh/id_ed25519 revproxy@bastion.asuforce.xyz -W %h:%p')
}

set :rails_env, 'production'
set :branch, 'master'
