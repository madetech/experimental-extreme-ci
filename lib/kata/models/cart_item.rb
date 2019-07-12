# frozen_string_literal: true

class Kata::CartItem
  attr_reader :product, :quantity

  def initialize(product, quantity)
    @product = product
    @quantity = quantity
  end
end
