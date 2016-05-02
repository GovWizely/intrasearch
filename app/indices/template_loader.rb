require 'active_support/core_ext/string/inflections'
require 'elasticsearch'

class TemplateLoader
  def initialize
    @client = Elasticsearch::Client.new
  end

  def load
    delete_templates
    each_template_name { |template_name| load_template template_name }
  end

  def delete_templates
    @client.indices.delete_template(name: "intrasearch-#{Intrasearch.env}-*") if templates_exist?
  end

  private

  def templates_exist?
    @client.indices.exists_template?(name: "intrasearch-#{Intrasearch.env}-*")
  end

  def each_template_name
    Dir["#{Intrasearch.root}/app/indices/templates/[0-9][0-9]*.rb"].each do |path|
      template_filename = File.basename path, '.rb'
      yield template_filename
    end
  end

  def extract_order_from_template_filename(template_filename)
    template_filename.scan(/\A(\d{2})\_/).flatten.map(&:to_i).first
  end

  def instantiate_template_class(numberless_template_name)
    numberless_template_name.camelize.constantize.new
  end

  def load_template(template_filename)
    numberless_template_filename = template_filename.gsub(/\A\d{2}\_/, '')
    template_name = ['intrasearch',
                     Intrasearch.env,
                     numberless_template_filename].join('-')
    template_order = extract_order_from_template_filename template_filename
    template = instantiate_template_class numberless_template_filename

    Intrasearch.logger.debug "loading: template_name: #{template_name}\ntemplate_hash: #{template.to_hash}"

    @client.indices.put_template name: template_name,
                                 order: template_order,
                                 body: template.to_hash
  end
end
