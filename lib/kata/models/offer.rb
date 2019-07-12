class Kata::Offer

  attr_reader :product, :offer_type, :dangerously_overloaded_argument_for_modifying_offers_of_different_types

  def initialize(offer_type, product, dangerously_overloaded_argument_for_modifying_offers_of_different_types)
    @offer_type = offer_type
    @dangerously_overloaded_argument_for_modifying_offers_of_different_types = dangerously_overloaded_argument_for_modifying_offers_of_different_types
    @product = product
  end

  def calculate_discount(catalog, product, quantity)
    unit_price = catalog.unit_price(product)
    quantity_as_int = quantity.to_i
    discount = nil

    if offer_type == Kata::SpecialOfferType::THREE_FOR_TWO && quantity_as_int >= 3
      discount = ThreeForTwo.new.to_discount(quantity, unit_price, quantity_as_int, product)
    elsif offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT
      if quantity_as_int >= 2
        total = dangerously_overloaded_argument_for_modifying_offers_of_different_types * quantity_as_int / 2 + quantity_as_int % 2 * unit_price
        discount_n = unit_price * quantity - total
        discount = Kata::Discount.new(product, "2 for " + dangerously_overloaded_argument_for_modifying_offers_of_different_types.to_s, discount_n)
      end
    elsif offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT
      if quantity_as_int >= 5
        discount_total = unit_price * quantity - (dangerously_overloaded_argument_for_modifying_offers_of_different_types * (quantity_as_int / 5) + quantity_as_int % 5 * unit_price)
        discount = Kata::Discount.new(product, "5 for " + dangerously_overloaded_argument_for_modifying_offers_of_different_types.to_s, discount_total)
      end
    elsif offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
      discount = Kata::Discount.new(product, dangerously_overloaded_argument_for_modifying_offers_of_different_types.to_s + "% off", quantity * unit_price * dangerously_overloaded_argument_for_modifying_offers_of_different_types / 100.0)
    end

    discount
  end

  class ThreeForTwo
    def to_discount(quantity, unit_price, quantity_as_int, product)
      discount_amount = quantity * unit_price - (((quantity_as_int / 3) * 2 * unit_price) + quantity_as_int % 3 * unit_price)
      Kata::Discount.new(product, "3 for 2", discount_amount)
    end
  end
end
