RSpec.configure do |config|
  config.before(:suite) do
    Elasticsearch::Persistence::Repository.new.client.indices.delete index: "intrasearch-#{Intrasearch.env}-*"
    require 'template_loader'
    TemplateLoader.new.load
  end

  config.after(:suite) do
    Elasticsearch::Persistence::Repository.new.client.indices.delete index: "intrasearch-#{Intrasearch.env}-*"
  end
end
