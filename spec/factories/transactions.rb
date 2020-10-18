FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_numer { 1 }
    credit_card_expiration_date { "MyString" }
    result { "MyString" }
  end
end
