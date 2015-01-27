require 'spec_helper'

class User < ActiveRecord::Base
  has_one :dog
end

class Dog < ActiveRecord::Base
end

describe FilterForm::InputOptionsBuilder do
  let(:search)  { User.search }
  let(:builder) { FilterForm::InputOptionsBuilder.new(object: search) }

  context 'association' do
    it 'returns correct options with predicate "select"' do
      builder.attribute_name = :dog

      result = builder.build

      expected_result = { as: :select, required: false, label: 'Dog EQUALS', input_html: { name: 'q[user_id_eq]' }, include_blank: true, selected: nil }
      expect(result.except(:collection)).to eq(expected_result)
    end
  end

  context 'boolean' do
    context 'default predicate' do
      it 'returns correct options with predicate "true"' do
        builder.attribute_name = :married

        result = builder.build

        expected_result = { as: :boolean, required: false, label: 'MARRIED IS TRUE', input_html: { name: 'q[married_true]', checked: false } }
        expect(result).to eq(expected_result)
      end
    end
  end

  context 'string' do
    context 'default predicate' do
      it 'returns correct options with predicate "cont"' do
        builder.attribute_name = :name

        expect(builder.build).to eq({ as: :string, required: false, label: 'NAME CONTAINS', input_html: { name: 'q[name_cont]' } })
      end
    end

    context "multiple" do
      it "returns attribute name as array with default predicate 'in'" do
        builder.attribute_name = :name
        result = builder.build(input_html: { multiple: true })

        expect(result).to eq({ as: :string, required: false, label: "NAME IN", input_html: { name: "q[name_in][]", multiple: true } })
      end
    end
  end

  context 'text' do
    context 'default predicate' do
      it 'returns correct options with predicate "cont"' do
        builder.attribute_name = :about

        result = builder.build

        expected_result = { as: :string, required: false, label: 'ABOUT CONTAINS', input_html: { name: 'q[about_cont]' } }
        expect(result).to eq(expected_result)
      end
    end
  end

  context 'money' do
    context 'default predicate' do
      it 'returns correct options with predicate "eq"' do
        builder.attribute_name = :amount

        result = builder.build

        expected_result = { as: :integer, required: false, label: 'AMOUNT EQUALS', input_html: { name: 'q[amount_eq]', step: 'any' } }
        expect(result).to eq(expected_result)
      end
    end
  end
end
