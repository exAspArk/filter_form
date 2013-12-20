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
        result  = builder.build({})
        options = { as: :boolean, required: false, label: 'Married IS TRUE', input_html: { name: 'q[married_true]', checked: false } }

        expect(result).to eq(options)
      end
    end
  end
end
