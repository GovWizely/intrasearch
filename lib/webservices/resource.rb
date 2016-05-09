module Webservices
  module Resource
    def self.extended(base)
      class << base
        attr_reader :resource_name
        attr_accessor :version
      end

      base.instance_variable_set :@resource_name, base.name.demodulize.tableize
      base.extend ModuleMethods
    end

    module ModuleMethods
      def all(extra_params = {})
        offset = 0

        Enumerator.new do |yielder|
          while offset
            body = get_body connection, offset, extra_params
            body.results.each { |result| yielder << result }
            next_offset = offset + body.results.count
            offset = next_offset < body.total ? next_offset : nil
          end
        end
      end

      private

      def connection
        Connection.get_instance
      end

      def get_body(connection, next_offset, extra_params)
        connection.get("/#{version}/#{resource_name}/search",
                       params(next_offset, extra_params)).body
      end

      def params(offset, extra_params)
        {
          api_key: Webservices.configuration.api_key,
          offset: offset,
          size: 100
        }.merge(extra_params)
      end
    end
  end
end
