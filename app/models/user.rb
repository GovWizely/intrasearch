require 'active_model/validations'
require 'active_model/validations/callbacks'
require 'active_support/core_ext/string/inflections'

require 'base_model'

class User
  include BaseModel
  include ActiveModel::Validations::Callbacks

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

  before_validation :normalize_email

  validates :email, presence: true
  validate :unique_email

  def self.where(params)
    term_clauses = params.map do |(k, v)|
      v = v.downcase if k.to_s == 'email' && v.present?
      {
        term: {
          k => v
        }
      }
    end
    response = all query: { bool: { must: term_clauses } }
    response.results
  end

  def self.find_by_id(id)
    find id
  rescue Elasticsearch::Persistence::Repository::DocumentNotFound
    nil
  end

  private

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end

  def unique_email
    if new_record? && email.present? && self.class.where(email: email).present?
      errors.add :email, 'has already been taken'
    end
  end
end
