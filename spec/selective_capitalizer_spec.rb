require "spec_helper"
require "capitalize_attributes/selective_capitalizer"

RSpec.describe ::CapitalizeAttributes::SelectiveCapitalizer do
  describe ".perform" do
    examples = [
      { value: "hello", expected_result: "Hello" },
      { value: "HELLO", expected_result: "Hello" },
      { value: "ziggy starbuck", expected_result: "Ziggy Starbuck" },
      { value: "MARY POPPINS", expected_result: "Mary Poppins" },
      { value: "henry McDonald", expected_result: "Henry McDonald" },
      { value: "john rockefeller, III", expected_result: "John Rockefeller, III" },
      { value: "slc", expected_result: "SLC" },
      { value: "rio de janeiro", expected_result: "Rio de Janeiro" },
      { value: "MANCHESTER ON THE THAMES", expected_result: "Manchester on the Thames" },
    ]

    examples.each do |example|
      value = example[:value]
      expected_result = example[:expected_result]

      context "when value is #{value}" do
        it "returns #{expected_result}" do
          expect(described_class.perform(value)).to eq(expected_result)
        end
      end
    end
  end
end
