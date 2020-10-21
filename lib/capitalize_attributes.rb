require "active_model"

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
      # Only capitalize the value if it is all lowercase or all uppercase.
      # This avoids inadvertently capitalizing names intended to have mixed
      # case, like "McDonald"
      if value.present? && (value.downcase == value || value.upcase == value)
        self.send("#{attr}=", value.titleize)
      end
    end

    # Don't cancel later callbacks
    true
  end
end
