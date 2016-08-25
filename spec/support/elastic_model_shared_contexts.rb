require 'active_support/core_ext/array/extract_options'

RSpec.shared_context 'elastic models' do |*model_classes|
  skip_load_yaml = model_classes.extract_options![:skip_load_yaml]
  before(:all) do
    model_classes.each do |model_class|
      IndexManager.new(model_class).setup_new_index! do
        next if skip_load_yaml
        model_source_filename = model_class.name.tableize
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
