class Kata::Product
  attr_reader :product_name, :unit_of_measure

  def initialize(product_name, unit_of_measure)
    @product_name = product_name
    @unit_of_measure = unit_of_measure
  end
end
