require 'active_support/core_ext/string/inflections'

require 'base_model'

class User
  include BaseModel
  append_index_namespace name.demodulize.tableize

  attribute :email, String, mapping: { index: 'not_analyzed' }
  attribute :encrypted_password, String, default: '', mapping: { index: 'not_analyzed' }
  attribute :reset_password_token, String, mapping: { index: 'not_analyzed' }
  attribute :reset_password_sent_at, DateTime, mapping: { index: 'not_analyzed' }

  attribute :remember_created_at, DateTime, mapping: { index: 'not_analyzed' }

  attribute :sign_in_count, Integer, default: 0, mapping: { index: 'not_analyzed' }
  attribute :current_sign_in_at, DateTime, mapping: { index: 'not_analyzed' }
  attribute :last_sign_in_at, DateTime, mapping: { index: 'not_analyzed' }
  attribute :current_sign_in_ip, String, mapping: { index: 'not_analyzed' }
  attribute :last_sign_in_ip, String, mapping: { index: 'not_analyzed' }

  attribute :failed_attempts, Integer, default: 0, mapping: { index: 'not_analyzed' }
  attribute :unlock_token, String, mapping: { index: 'not_analyzed' }
  attribute :locked_at, DateTime, mapping: { index: 'not_analyzed' }

  validates :email, presence: true

  def self.where(params)
    term_clauses = params.map do |(k, v)|
      {
        term: {
          k => v
        }
      }
    end
    response = search query: { bool: { must: term_clauses } }
    response.results
  end

  def self.find_by_id(id)
    find id
  rescue Elasticsearch::Persistence::Repository::DocumentNotFound
    nil
  end
end
