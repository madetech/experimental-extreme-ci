class Kata::Offer

  attr_reader :product, :offer_type, :argument

  def initialize(offer_type, product, dangerously_overloaded_argument_for_modifying_offers_of_different_types)
    @offer_type = offer_type
    @argument = dangerously_overloaded_argument_for_modifying_offers_of_different_types
    @product = product
  end

end
