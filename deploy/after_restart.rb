revision = `cd #{release_path} && git rev-parse HEAD`.chomp

deploy = {
  'user' => new_resource.user,
  'group' => new_resource.group,
  'cwd' => release_path,
  'environment' => {
    'PATH' => "/home/#{new_resource.user}/.rbenv/shims:/usr/bin:/bin",
    'RACK_ENV' => new_resource.environment['RACK_ENV'],
    'REPOSITORY' => new_resource.repo,
    'REVISION' => revision,
    'USERNAME' => new_resource.user
  }
}

after_restart_notification_disabled = node['intrasearch_data']['after_restart_notification_disabled']

execute 'rake airbrake_deployments' do
  user deploy['user']
  group deploy['group']
  cwd deploy['cwd']
  environment deploy['environment']
  command 'bundle exec rake airbrake_deployments'
  not_if { after_restart_notification_disabled }
end

execute 'newrelic deployments' do
  user deploy['user']
  group deploy['group']
  cwd deploy['cwd']
  environment deploy['environment']
  command "bundle exec newrelic deployments -u #{deploy['user']} -r #{revision}"
  not_if { after_restart_notification_disabled }
end
