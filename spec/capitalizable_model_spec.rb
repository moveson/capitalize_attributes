require "shared_examples/capitalize_attributes"

class CapitalizableModel
  include ::ActiveModel::Attributes
  include ::ActiveModel::Validations
  include ::ActiveModel::Validations::Callbacks
  include ::CapitalizeAttributes

  attribute :first_name
  attribute :last_name
  attribute :city

  capitalize_attributes :first_name, :last_name
  capitalize_attribute :city
end

RSpec.describe ::CapitalizableModel do
  it_behaves_like "capitalize_attributes", :first_name, :last_name, :city
end
