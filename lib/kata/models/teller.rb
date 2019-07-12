class Kata::Teller

  def initialize(catalog)
    @catalog = catalog
    @offers = Offers.new
  end

  class Offers
    def initialize
      @offers = {}
    end

    def []=(key, value)
      @offers[key] = value
    end

    def [](key)
      @offers[key]
    end

    def available_for?(key)
      @offers.key?(key)
    end
  end

  def add_special_offer(offer_type, product, argument)
    @offers[product] = Kata::Offer.new(offer_type, product, argument)
  end

  def checks_out_articles_from(the_cart)
    receipt = Kata::Receipt.new
    cart_items = the_cart.items
    for item in cart_items do
      product = item.product
      quantity = item.quantity
      unit_price = @catalog.unit_price(product)
      price = quantity * unit_price
      receipt.add_product(product, quantity, unit_price, price)
    end
    the_cart.handle_offers(receipt, @offers, @catalog)

    receipt
  end

end
