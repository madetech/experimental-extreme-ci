class Kata::Product
  attr_reader :name, :unit

  def initialize(product_name, unit)
    @name = product_name
    @unit = unit
  end
end
