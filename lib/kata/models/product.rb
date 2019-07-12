class Kata::Product
  attr_reader :product_name, :unit

  def initialize(product_name, unit)
    @product_name = product_name
    @unit = unit
  end
end
