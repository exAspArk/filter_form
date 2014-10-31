require 'spec_helper'

class User < ActiveRecord::Base
end

describe FilterForm::InputOptionsBuilder do
  let(:search)  { User.search }
  let(:builder) { FilterForm::InputOptionsBuilder.new(object: search) }

  context 'boolean' do
    before do
      builder.attribute_name = :married
    end

    context 'default predicate' do
      it 'returns correct options with predicate "true"' do
        result  = builder.build
        options = { as: :boolean, required: false, label: 'MARRIED IS TRUE', input_html: { name: 'q[married_true]', checked: false } }
        expect(result).to eq(options)
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
    before do
      builder.attribute_name = :about
    end

    context 'default predicate' do
      it 'returns correct options with predicate "cont"' do
        result  = builder.build
        options = { as: :string, required: false, label: 'ABOUT CONTAINS', input_html: { name: 'q[about_cont]' } }
        expect(result).to eq(options)
      end
    end
  end

  context 'money' do
    before do
      builder.attribute_name = :amount
    end

    context 'default predicate' do
      it 'returns correct options with predicate "eq"' do
        result  = builder.build
        options = { as: :integer, required: false, label: 'AMOUNT EQUALS', input_html: { name: 'q[amount_eq]', step: 'any' } }
        expect(result).to eq(options)
      end
    end
  end

  context 'predicate selector' do
    before do
      builder.attribute_name = :amount
    end

    it 'options do not replace each other' do
      result  = builder.build(predicate_selector: [['>', 'gt']])
      expect(result[:input_html].keys).to include :'data-predicate-selector', :'data-current-predicate'
    end
  end

end
