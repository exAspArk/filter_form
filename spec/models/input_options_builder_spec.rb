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
    before do
      builder.attribute_name = :name
    end

    context 'default predicate' do
      it 'returns correct options with predicate "cont"' do
        result  = builder.build
        options = { as: :string, required: false, label: 'NAME CONTAINS', input_html: { name: 'q[name_cont]' } }
        expect(result).to eq(options)
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
end
