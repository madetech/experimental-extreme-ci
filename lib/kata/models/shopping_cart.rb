class Kata::ShoppingCart

  def initialize
    @cart_add_events = []
    @cart_items = CartItems.new
  end

  def items
    @cart_add_events.dup
  end

  class CartItems
    def initialize
      @items = {}
    end

    def add(product, quantity)
      if @items.key?(product)
        @items[product] = @items[product] + quantity
      else
        @items[product] = quantity
      end
    end

    def products
      @items.keys
    end

    def quantity_of(product)
      @items[product]
    end
  end

  def add_item_quantity(product, quantity)
    @cart_add_events << Kata::CartItem.new(product, quantity)
    @cart_items.add(product, quantity)
  end

  def handle_offers(receipt, offers, catalog)
    @cart_items
      .products
      .select(&offers.method(:available_for?))
      .each do |product|
      quantity = @cart_items.quantity_of(product)

      offer = offers.for(product)
      unit_price = catalog.unit_price(product)
      quantity_as_int = quantity.to_i
      discount = nil

      if offer.offer_type == Kata::SpecialOfferType::THREE_FOR_TWO && quantity_as_int >= 3
        discount_amount = quantity * unit_price - (((quantity_as_int / 3) * 2 * unit_price) + quantity_as_int % 3 * unit_price)
        discount = Kata::Discount.new(product, "3 for 2", discount_amount)
      elsif offer.offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT
        if quantity_as_int >= 2
          total = offer.dangerously_overloaded_argument_for_modifying_offers_of_different_types * quantity_as_int / 2 + quantity_as_int % 2 * unit_price
          discount_n = unit_price * quantity - total
          discount = Kata::Discount.new(product, "2 for " + offer.dangerously_overloaded_argument_for_modifying_offers_of_different_types.to_s, discount_n)
        end
      elsif offer.offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT
        if quantity_as_int >= 5
          discount_total = unit_price * quantity - (offer.dangerously_overloaded_argument_for_modifying_offers_of_different_types * (quantity_as_int / 5) + quantity_as_int % 5 * unit_price)
          discount = Kata::Discount.new(product, "5 for " + offer.dangerously_overloaded_argument_for_modifying_offers_of_different_types.to_s, discount_total)
        end
      elsif offer.offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
        discount = Kata::Discount.new(product, offer.dangerously_overloaded_argument_for_modifying_offers_of_different_types.to_s + "% off", quantity * unit_price * offer.dangerously_overloaded_argument_for_modifying_offers_of_different_types / 100.0)
      end

      receipt.add_discount(discount) if discount
    end
  end

end
