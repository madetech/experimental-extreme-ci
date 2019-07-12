class Kata::Product
  attr_reader :product_name, :unit

  def initialize(product_name, unit_of_measure)
    @product_name = product_name
    @unit = unit_of_measure
  end
end
