node['deploy'].each do |_application, deploy|
  execute 'intrasearch:setup_indices' do
    user deploy['user']
    group deploy['group']
    cwd release_path
    environment deploy['environment']
    command 'bundle exec rake intrasearch:setup_indices'
  end
end
