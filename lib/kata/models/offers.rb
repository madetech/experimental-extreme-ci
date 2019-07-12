class Kata::Offers
  def initialize
    @offers = {}
  end

  def add(offer)
    @offers[offer.product] = offer
  end

  def for(product)
    @offers[product]
  end

  def available_for?(key)
    @offers.key?(key)
  end
end
