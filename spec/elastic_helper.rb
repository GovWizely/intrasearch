require 'active_support/core_ext/string/inflections'

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

RSpec.shared_context 'shared elastic models' do |*shared_model_classes|
  before(:all) do
    shared_model_classes.each do |model_class|
      IndexManager.new(model_class).setup_new_index! do
        model_source_filename = model_class.name.pluralize.tableize
        yaml = YAML.load Intrasearch.root.join("spec/fixtures/yaml/#{model_source_filename}.yml").read
        yaml.each do |model_hash|
          model_class.create model_hash
        end
      end
    end
  end

  after(:all) do
    Elasticsearch::Persistence::Repository.new.client.indices.delete index: "intrasearch-#{Intrasearch.env}-*"
  end
end



