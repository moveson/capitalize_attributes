class CapitalizableModel
  include ::ActiveModel::Attributes
  include ::ActiveModel::Validations
  include ::ActiveModel::Validations::Callbacks
  include ::CapitalizeAttributes

  attribute :first_name
  attribute :last_name
  attribute :city
  attribute :password
  attribute :encrypted_password

  capitalize_attributes :first_name, :last_name
  capitalize_attribute :city
end
