# intrasearch

Provides JSON Search API for Salesforce contents.

## Dependencies

- Ruby 2.2
- Bundler 1.10.6
- Elasticsearch 1.7.3
- Salesforce API user credentials

## Setup

- Start elasticsearch
- Copy `config/intrasearch.yml.example` to `config/intrasearch.yml`
- Copy `config/restforce.yml.example` to `config/restforce.yml` and fill out the attributes
- Run `bundle`
- Setup indices: `bundle exec rake intrasearch:setup_indices`
- Import taxonomies: `bundle exec rake intrasearch:import_taxonomies`
- Import articles: `bundle exec rake intrasearch:import_articles`
- Start the app: `bundle exec guard`
- Access the console: `bundle exec rack-console`

## Endpoints

- [localhost:9292/v1/articles/count](http://localhost:9292/v1/articles/count)
- [localhost:9292/v1/articles/search?q=trade](http://localhost:9292/v1/articles/search?q=trade)

Cheers!
