require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    let!(:author) { FactoryBot.create(:author) }
    let!(:book) { FactoryBot.create(:book, author: author) }

    it "is valid with valid attributes" do
      expect(book.valid?).to eq(true)
    end

    context "title" do
      it "is not valid without a title" do
        book.title = ''
        expect(book.valid?).to eq(false)
      end

      it "is not valid with a title < 3" do
        book.title = '12'
        expect(book.valid?).to eq(false)
      end

      it "is not valid with a title > 50" do
        book.title = 'a' * 51
        expect(book.valid?).to eq(false)
      end
    end

    it "is not valid without a description"

  end
end
