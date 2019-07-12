class FakeCatalog < Kata::SupermarketCatalog

  def initialize
    @products = {}
    @prices = {}
  end

  def add_product(product, price)
    @products[product.product_name] = product
    @prices[product.product_name] = price
  end

  def unit_price(p)
    @prices.fetch(p.product_name)
  end

end
