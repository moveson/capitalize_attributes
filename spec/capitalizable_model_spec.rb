require "capitalizable_model"
require "shared_examples/capitalize_attributes"

RSpec.describe ::CapitalizableModel do
  it_behaves_like "capitalize_attributes", :first_name, :last_name, :city
end
