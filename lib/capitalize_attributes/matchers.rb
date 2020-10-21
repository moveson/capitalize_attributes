module CapitalizeAttributes
  module Matchers

    # RSpec Examples:
    #
    #   it { is_expected.to capitalize_attribute(:first_name) }
    #   it { is_expected.to capitalize_attributes(:first_name, :last_name) }
    #   it { is_expected.not_to capitalize_attribute(:password) }
    #   it { is_expected.not_to capitalize_attributes(:password, :encrypted_password) }
    def capitalize_attribute(*attributes)
      CapitalizeAttributeMatcher.new(attributes)
    end

    alias_method :capitalize_attributes, :capitalize_attribute

    class CapitalizeAttributeMatcher
      def initialize(attributes)
        @attributes = attributes
        @options = {}
      end

      def matches?(subject)
        @attributes.all? do |attribute|
          @attribute = attribute
          subject.send("#{@attribute}=", "string")
          subject.validate
          subject.send(@attribute) == "String"
        end
      end

      def failure_message # RSpec 3.x
        "Expected #{@attribute} to be capitalized, but it was not"
      end

      alias_method :failure_message_for_should, :failure_message # RSpec 1.2, 2.x, and minitest-matchers

      def failure_message_when_negated # RSpec 3.x
        "Expected #{@attribute} not to be capitalized, but it was"
      end

      alias_method :failure_message_for_should_not, :failure_message_when_negated # RSpec 1.2, 2.x, and minitest-matchers
      alias_method :negative_failure_message, :failure_message_when_negated # RSpec 1.1

      def description
        "capitalize #{@attributes.map { |el| "##{el}" }.to_sentence}"
      end
    end
  end
end
