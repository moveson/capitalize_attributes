require "rspec/matchers"
require "spec_helper"
require "capitalize_attributes/matchers"
require "capitalizable_model"

RSpec.describe CapitalizableModel do
  include CapitalizeAttributes::Matchers

  it { is_expected.to capitalize_attribute(:first_name) }
  it { is_expected.to capitalize_attributes(:last_name, :city) }
  it { is_expected.not_to capitalize_attribute(:password) }
  it { is_expected.not_to capitalize_attributes(:password, :encrypted_password) }
end
