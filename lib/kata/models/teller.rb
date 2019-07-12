class Kata::Teller

  def initialize(catalog)
    @catalog = catalog
    @offers = Kata::Offers.new
  end

  def add_special_offer(offer_type, product, argument)

    if offer_type == Kata::SpecialOfferType::THREE_FOR_TWO
      offer = Kata::Offer::ThreeForTwo.new
    elsif offer_type == Kata::SpecialOfferType::TWO_FOR_AMOUNT
      offer = Kata::Offer::TwoForAmount.new
    elsif offer_type == Kata::SpecialOfferType::FIVE_FOR_AMOUNT
      offer = Kata::Offer::FiveForAmount.new
    elsif offer_type == Kata::SpecialOfferType::TEN_PERCENT_DISCOUNT
      offer = Kata::Offer::TenPercentDiscount.new
    end

    @offers.add(Kata::Offer.new(offer, product, argument))
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
