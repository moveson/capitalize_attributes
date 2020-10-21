require "active_model"
require "capitalize_attributes/selective_capitalizer"

module CapitalizeAttributes
  extend ::ActiveSupport::Concern

  included do
    before_validation :capitalize_record
    class_attribute :capitalizable_attribute_names
    self.capitalizable_attribute_names = []
  end

  module ClassMethods
    def capitalize_attributes(*attributes)
      attributes.each(&method(:capitalize_attribute))
    end

    def capitalize_attribute(attribute)
      self.capitalizable_attribute_names << attribute.to_s
    end
  end

  private

  def capitalize_record
    capitalizable_attributes = attributes.slice(*self.capitalizable_attribute_names)

    capitalizable_attributes.each do |attr, value|
      if value.present?
        new_value = ::CapitalizeAttributes::SelectiveCapitalizer.perform(value)
        self.send("#{attr}=", new_value) if new_value != value
      end
    end

    # Don't cancel later callbacks
    true
  end
end
