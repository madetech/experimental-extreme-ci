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

      discount = offer.apply(catalog, product, quantity)

      receipt.add_discount(discount) if discount
    end
  end

end
