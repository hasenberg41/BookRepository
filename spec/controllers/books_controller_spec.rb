require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  it 'has a max limit of 100' do
    expect(Book).to receive(:limit).with(max_pagination_limit).and_call_original

    get :index, params: { limit: (max_pagination_limit + 1) }
  end
end
