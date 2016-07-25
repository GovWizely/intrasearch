require 'base_article_extractor'
require 'extractable'

module ArticleExtractor
  extend Extractable
  self.api_name = 'Article__kav'.freeze
  extend BaseArticleExtractor

  self.query_template = <<-SOQL
    SELECT Atom__c,
           (SELECT Id, DataCategoryName, DataCategoryGroupName FROM DataCategorySelections),
           Guide__c,
           Id,
           Summary,
           Title,
           UrlName
    FROM %{api_name}
    WHERE PublishStatus = 'Online'
    AND Language = 'en_US'
    AND IsLatestVersion=true
    AND IsVisibleInPkb=true
  SOQL

  self.column_mapping = {
    atom: 'Atom__c',
    guide: 'Guide__c',
    id: 'Id',
    summary: 'Summary',
    title: 'Title',
    url_name: 'UrlName'
  }.freeze
end
