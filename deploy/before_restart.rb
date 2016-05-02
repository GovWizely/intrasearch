deploy = {
  'user' => new_resource.user,
  'group' => new_resource.group,
  'cwd' => release_path,
  'environment' => new_resource.environment.merge(
    'PATH' => "/home/#{new_resource.user}/.rbenv/shims:/usr/bin:/bin"
  )
}

execute 'intrasearch:setup_indices' do
  user deploy['user']
  group deploy['group']
  cwd deploy['cwd']
  environment deploy['environment']
  command 'bundle exec rake intrasearch:setup_indices'
end
