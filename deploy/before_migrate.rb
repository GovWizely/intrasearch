node['deploy'].each do |_application, deploy|
  env_vars = deploy['environment']

  template "#{deploy['deploy_to']}/shared/config/restforce.yml" do
    source "#{release_path}/config/restforce.yml.erb"
    local true
    mode '0600'
    group deploy['group']
    owner deploy['user']
    variables(environment: env_vars['RACK_ENV'],
              client_id: env_vars['sfdc_client_id'],
              client_secret: env_vars['sfdc_client_secret'],
              host: env_vars['sfdc_host'],
              username: env_vars['sfdc_username'],
              password: env_vars['sfdc_password'])

    only_if do
      env_vars['sfdc_password'].present?
    end
  end

  template "#{deploy['deploy_to']}/shared/config/intrasearch.yml" do
    source "#{release_path}/config/intrasearch.yml.erb"
    local true
    mode '0600'
    group deploy['group']
    owner deploy['user']
    variables(environment: env_vars['RACK_ENV'],
              article_url_prefix: deploy['config_data']['article_url_prefix'])

    only_if do
      deploy['config_data']['article_url_prefix'].present?
    end
  end
end
