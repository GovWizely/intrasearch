require 'active_support/core_ext/string/filters'
require 'active_support/core_ext/string/inflections'
require 'restforce'
require 'sanitize'

module ArticleExtractor
  QUERY_TEMPLATE = <<-SOQL
    SELECT Atom__c,
           (SELECT Id, DataCategoryName, DataCategoryGroupName FROM DataCategorySelections),
           Id,
           LastPublishedDate,
           Summary,
           Title,
           UrlName
    FROM %{api_name}
    WHERE PublishStatus = 'Online'
    AND Language = 'en_US'
    AND IsLatestVersion=true
    AND IsVisibleInPkb=true
  SOQL

  COLUMN_MAPPING = {
    atom: 'Atom__c',
    id: 'Id',
    summary: 'Summary',
    title: 'Title',
    url_name: 'UrlName'
  }.freeze

  DATA_CATEGORY_GROUP_NAMES = %w(Geographies Industries Trade_Topics).freeze

  def query
    @query ||= (QUERY_TEMPLATE % ({ api_name: api_name })).squish
  end

  def extract
    collection = Restforce.new.query query
    Enumerator.new(collection.size) do |y|
      collection.each do |record|
        y << extract_record(record)
      end
    end
  end

  private

  def extract_record(record)
    hash = extract_columns record, COLUMN_MAPPING
    hash.merge! extract_published_date record['LastPublishedDate']
    hash.merge! extract_taxonomies record['DataCategorySelections']
  end

  def extract_columns(attributes, columns)
    extracted_hash = {}
    columns.each do |target, source|
      extracted_hash[target] = sanitize_value(attributes[source])
    end
    extracted_hash
  end

  def sanitize_value(value)
    Sanitize.fragment(value).squish if value
  end

  def extract_published_date(last_published_date)
    published_date = DateTime.parse(last_published_date) rescue nil
    { published_date: published_date }
  end

  def extract_taxonomies(data_categories)
    filtered_data_categories = filter_data_categories data_categories

    filtered_data_categories.each_with_object(Hash.new { |h, k| h[k] = [] }) do |dc, taxonomies|
      group_name = dc.DataCategoryGroupName.tableize.to_sym
      taxonomies[group_name] << dc.DataCategoryName.gsub(%r{_}, ' ')
    end
  end

  def filter_data_categories(data_categories)
    data_categories ||= []
    data_categories.select do |dc|
      DATA_CATEGORY_GROUP_NAMES.include? dc.DataCategoryGroupName
    end
  end
end
