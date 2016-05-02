# intrasearch

[![Build Status](https://travis-ci.org/GovWizely/intrasearch.svg?branch=travis)](https://travis-ci.org/GovWizely/intrasearch)
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
