# frozen_string_literal: true

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
      @items[product] = if @items.key?(product)
                          @items[product] + quantity
                        else
                          quantity
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
    products_with_offer(offers).each do |product|
      quantity = @cart_items.quantity_of(product)

      offer = offers.for(product)

      discount = offer.calculate_discount(catalog, product, quantity)

      receipt.add_discount(discount) if discount
    end
  end

  private

  def products_with_offer(offers)
    @cart_items.products.select(&offers.method(:available_for?))
  end
end
