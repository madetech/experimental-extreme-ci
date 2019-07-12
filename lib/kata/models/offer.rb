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

    if offer_type == Kata::SpecialOfferType::THREE_FOR_TWO && quantity_as_int >= 3
      foo = ThreeForTwo.new
    elsif offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT
      foo = TwoForAmount.new
    elsif offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT
      foo = FiveForAmount.new
    elsif offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
      foo = TenPercentDiscount.new
    end

    discount = foo&.to_discount(quantity, unit_price, quantity_as_int, product, dangerously_overloaded_argument_for_modifying_offers_of_different_types)

    discount
  end

  class ThreeForTwo
    def to_discount(quantity, unit_price, quantity_as_int, product, dangerously_overloaded_argument_for_modifying_offers_of_different_types)
      discount_amount = quantity * unit_price - (((quantity_as_int / 3) * 2 * unit_price) + quantity_as_int % 3 * unit_price)
      Kata::Discount.new(product, "3 for 2", discount_amount)
    end
  end

  class TwoForAmount
    def to_discount(quantity, unit_price, quantity_as_int, product, dangerously_overloaded_argument_for_modifying_offers_of_different_types)
      if quantity_as_int >= 2
        total = dangerously_overloaded_argument_for_modifying_offers_of_different_types * quantity_as_int / 2 + quantity_as_int % 2 * unit_price
        discount_n = unit_price * quantity - total
        Kata::Discount.new(product, "2 for " + dangerously_overloaded_argument_for_modifying_offers_of_different_types.to_s, discount_n)
      end
    end
  end

  class FiveForAmount
    def to_discount(quantity, unit_price, quantity_as_int, product, dangerously_overloaded_argument_for_modifying_offers_of_different_types)
      if quantity_as_int >= 5
        discount_total = unit_price * quantity - (dangerously_overloaded_argument_for_modifying_offers_of_different_types * (quantity_as_int / 5) + quantity_as_int % 5 * unit_price)
        Kata::Discount.new(product, "5 for " + dangerously_overloaded_argument_for_modifying_offers_of_different_types.to_s, discount_total)
      end
    end
  end

  class TenPercentDiscount
    def to_discount(quantity, unit_price, quantity_as_int, product, dangerously_overloaded_argument_for_modifying_offers_of_different_types)
      Kata::Discount.new(product, dangerously_overloaded_argument_for_modifying_offers_of_different_types.to_s + "% off", quantity * unit_price * dangerously_overloaded_argument_for_modifying_offers_of_different_types / 100.0)
    end
  end
end
