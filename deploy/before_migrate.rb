deploy = new_resource
env_vars = new_resource.environment

template_config = {
  'airbrake.yml' => {
    environment: env_vars['RACK_ENV'],
    airbrake_project_id: env_vars['airbrake_project_id'],
    airbrake_project_key: env_vars['airbrake_project_key']
  },
  'intrasearch.yml' => {
    environment: env_vars['RACK_ENV'],
    article_url_prefix: node['intrasearch_data']['base_article_url_prefix'],
    privacy_shield_article_url_prefix: node['intrasearch_data']['privacy_shield_article_url_prefix'],
    stop_fakes_article_url_prefix: node['intrasearch_data']['stop_fakes_article_url_prefix'],
    trade_event_url_prefix: node['intrasearch_data']['trade_event_url_prefix'],
    trade_lead_url_prefix: node['intrasearch_data']['trade_lead_url_prefix'],
    web_document_domains: node['intrasearch_data']['web_document_domains']
  },
  'restforce.yml' => {
    environment: env_vars['RACK_ENV'],
    client_id: env_vars['sfdc_client_id'],
    client_secret: env_vars['sfdc_client_secret'],
    host: env_vars['sfdc_host'],
    username: env_vars['sfdc_username'],
    password: env_vars['sfdc_password']
  },
  'newrelic.yml' => {
    newrelic_license_key: env_vars['newrelic_license_key']
  },
  'webservices.yml' => {
    environment: env_vars['RACK_ENV'],
    api_key: env_vars['webservices_api_key'],
    host_url: env_vars['webservices_host_url']
  }
}

template_config.each do |filename, vars|
  template "#{deploy.deploy_to}/shared/config/#{filename}" do
    source "#{release_path}/config/#{filename}.erb"
    local true
    mode '0400'
    group deploy.group
    owner deploy.user
    variables vars
  end
end
