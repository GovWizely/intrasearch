deploy = new_resource
env_vars = new_resource.environment

template "#{deploy.deploy_to}/shared/config/airbrake.yml" do
  source "#{release_path}/config/airbrake.yml.erb"
  local true
  mode '0400'
  group deploy.group
  owner deploy.user
  variables(environment: env_vars['RACK_ENV'],
            airbrake_project_id: env_vars['airbrake_project_id'],
            airbrake_project_key: env_vars['airbrake_project_key'])
end

template "#{deploy.deploy_to}/shared/config/restforce.yml" do
  source "#{release_path}/config/restforce.yml.erb"
  local true
  mode '0400'
  group deploy.group
  owner deploy.user
  variables(environment: env_vars['RACK_ENV'],
            client_id: env_vars['sfdc_client_id'],
            client_secret: env_vars['sfdc_client_secret'],
            host: env_vars['sfdc_host'],
            username: env_vars['sfdc_username'],
            password: env_vars['sfdc_password'])
end

template "#{deploy.deploy_to}/shared/config/intrasearch.yml" do
  source "#{release_path}/config/intrasearch.yml.erb"
  local true
  mode '0400'
  group deploy.group
  owner deploy.user
  variables(environment: env_vars['RACK_ENV'],
            article_url_prefix: node['intrasearch_data']['base_article_url_prefix'],
            web_document_domains: node['intrasearch_data']['web_document_domains'])
end

template "#{deploy.deploy_to}/shared/config/newrelic.yml" do
  source "#{release_path}/config/newrelic.yml.erb"
  local true
  mode '0400'
  group deploy.group
  owner deploy.user
  variables newrelic_license_key: env_vars['newrelic_license_key']
end
