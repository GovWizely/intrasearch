# intrasearch

[![Build Status](https://travis-ci.org/GovWizely/intrasearch.svg?branch=master)](https://travis-ci.org/GovWizely/intrasearch)
[![Code Climate](https://codeclimate.com/github/GovWizely/intrasearch/badges/gpa.svg)](https://codeclimate.com/github/GovWizely/intrasearch)
[![Test Coverage](https://codeclimate.com/github/GovWizely/intrasearch/badges/coverage.svg)](https://codeclimate.com/github/GovWizely/intrasearch/coverage)

Provides JSON Search API for Salesforce contents.

## Dependencies

- Ruby 2.2
- Bundler 1.11.2
- Elasticsearch 2.2.2
- Salesforce API user credentials

## Setup

- Start elasticsearch
- Copy `config/intrasearch.yml.example` to `config/intrasearch.yml`
- Copy `config/restforce.yml.example` to `config/restforce.yml` and fill out the attributes
- Copy `config/webservices.yml.example` to `config/webservices.yml` and update the attributes
- Run `bundle`
- Setup indices: `bundle exec rake intrasearch:setup_indices`
- Import all types of content: `bundle exec rake intrasearch:import_all`
- Import articles: `bundle exec rake intrasearch:import_articles`
- Start the app: `bundle exec guard`
- Access the console: `bundle exec rack-console`

## Endpoints

- [localhost:9292/admin/users](http://localhost:9292/admin/users)
- [POST localhost:9292/admin/users](http://localhost:9292/admin/users)
- [localhost:9292/admin/users/:id](http://localhost:9292/admin/users/:id)
- [PATCH localhost:9292/admin/users/:id](http://localhost:9292/admin/users/:id)
- [localhost:9292/admin/trade_events](http://localhost:9292/admin/trade_events)
- [localhost:9292/admin/trade_events/:id](http://localhost:9292/admin/trade_events/:id)
- [PATCH localhost:9292/admin/trade_events/:id](http://localhost:9292/admin/trade_events/:id)
- [localhost:9292/v1/how_to_export_articles/count](http://localhost:9292/v1/how_to_export_articles/count)
- [localhost:9292/v1/how_to_export_articles/search?q=trade](http://localhost:9292/v1/how_to_export_articles/search?q=trade)
- [localhost:9292/v1/market_intelligence_articles/count](http://localhost:9292/v1/market_intelligence_articles/count)
- [localhost:9292/v1/market_intelligence_articles/search?q=trade](http://localhost:9292/v1/market_intelligence_articles/search?q=trade)
- [localhost:9292/v1/privacy_shield_articles/count](http://localhost:9292/v1/privacy_shield_articles/count)
- [localhost:9292/v1/privacy_shield_articles/search?q=trade](http://localhost:9292/v1/privacy_shield_articles/search?q=trade)
- [localhost:9292/v1/stop_fakes_articles/count](http://localhost:9292/v1/stop_fakes_articles/count)
- [localhost:9292/v1/stop_fakes_articles/search?q=trade](http://localhost:9292/v1/stop_fakes_articles/search?q=trade)
- [localhost:9292/v1/trade_events/count](http://localhost:9292/v1/trade_events/count)
- [localhost:9292/v1/trade_events/search](http://localhost:9292/v1/trade_events/search?q=trade)
- [localhost:9292/v1/trade_events/:id](http://localhost:9292/v1/trade_events/:id)
- [localhost:9292/v1/trade_leads/count](http://localhost:9292/v1/trade_leads/count)
- [localhost:9292/v1/trade_leads/search](http://localhost:9292/v1/trade_leads/search?q=trade)
- [localhost:9292/v1/trade_leads/:id](http://localhost:9292/v1/trade_leads/:id)
- [localhost:9292/v1/web_documents/count](http://localhost:9292/v1/web_documents/count)
- [localhost:9292/v1/web_documents/search?q=trade](http://localhost:9292/v1/web_documents/search?domain=CHANGEME&q=trade)

Cheers!
