RSpec.shared_examples_for "capitalize_attributes" do |*capitalizable_attribute_names|
  subject { described_class.new }

  describe ".capitalizable_attribute_names" do
    it "sets as expected" do
      expected_attribute_names = capitalizable_attribute_names.map(&:to_s)
      expect(described_class.capitalizable_attribute_names).to match_array(expected_attribute_names)
    end
  end

  describe "before validation" do
    capitalizable_attribute_names.each do |attribute_name|
      context "for attribute #{attribute_name}" do
        let(:setter_method) { "#{attribute_name}=" }
        it "capitalizes all-lowercased fields" do
          subject.send(setter_method, "lazy name")
          subject.validate

          expect(subject.send(attribute_name)).to eq("Lazy Name")
        end

        it "capitalizes all-uppercased fields" do
          subject.send(setter_method, "SHOUTING NAME")
          subject.validate

          expect(subject.send(attribute_name)).to eq("Shouting Name")
        end

        it "does not modify mixed-case fields" do
          subject.send(setter_method, "McMixed Case Name")
          subject.validate

          expect(subject.send(attribute_name)).to eq("McMixed Case Name")
        end

        it "does not modify nil fields" do
          subject.send(setter_method, nil)
          subject.validate

          expect(subject.send(attribute_name)).to eq(nil)
        end
      end
    end
  end
end
