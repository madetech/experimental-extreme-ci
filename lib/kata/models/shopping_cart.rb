class Kata::ShoppingCart
  attr_reader :cart_items

  def initialize
    @cart_add_events = []
    @cart_items = {}
  end

  def items
    @cart_add_events.dup
  end

  def add_item_quantity(product, quantity)
    @cart_add_events << Kata::CartItem.new(product, quantity)
    if cart_items.key?(product)
      cart_items[product] = cart_items[product] + quantity
    else
      cart_items[product] = quantity
    end
  end

  def handle_offers(receipt, offers, catalog)
    for p in cart_items.keys do
      quantity = cart_items[p]

      next unless offers.key?(p)

      offer = offers[p]
      unit_price = catalog.unit_price(p)
      quantity_as_int = quantity.to_i
      discount = nil
      x = 1

      if offer.offer_type == Kata::SpecialOfferType::THREE_FOR_TWO
        x = 3
      elsif offer.offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT
        x = 2
        if quantity_as_int >= 2
          total = offer.dangerously_overloaded_argument_for_modifying_offers_of_different_types * quantity_as_int / x + quantity_as_int % 2 * unit_price
          discount_n = unit_price * quantity - total
          discount = Kata::Discount.new(p, "2 for " + offer.dangerously_overloaded_argument_for_modifying_offers_of_different_types.to_s, discount_n)
        end
      end

      if offer.offer_type == Kata::SpecialOfferType:: FIVE_FOR_AMOUNT
        x = 5
      end

      number_of_x = quantity_as_int / x

      if offer.offer_type == Kata::SpecialOfferType::THREE_FOR_TWO && quantity_as_int > 2
        discount_amount = quantity * unit_price - ((number_of_x * 2 * unit_price) + quantity_as_int % 3 * unit_price)
        discount = Kata::Discount.new(p, "3 for 2", discount_amount)
      end

      if offer.offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
        discount = Kata::Discount.new(p, offer.dangerously_overloaded_argument_for_modifying_offers_of_different_types.to_s + "% off", quantity * unit_price * offer.dangerously_overloaded_argument_for_modifying_offers_of_different_types / 100.0)
      end

      if offer.offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT && quantity_as_int >= 5
        discount_total = unit_price * quantity - (offer.dangerously_overloaded_argument_for_modifying_offers_of_different_types * number_of_x + quantity_as_int % 5 * unit_price)
        discount = Kata::Discount.new(p, "5 for " + offer.dangerously_overloaded_argument_for_modifying_offers_of_different_types.to_s, discount_total)
      end

      receipt.add_discount(discount) if discount
    end
  end

end
