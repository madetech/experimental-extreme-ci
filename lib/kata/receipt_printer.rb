class Kata::ReceiptPrinter

  def initialize(columns = 40)
    @columns = columns
  end

  def print_receipt(receipt)
    result = ""
    for item in receipt.items do
      result.concat(print_item(item));
    end
    for discount in receipt.discounts do
      product_presentation = discount.product.product_name
      price_presentation = "%.2f" % discount.discount_amount
      description = discount.description
      result.concat(description)
      result.concat("(")
      result.concat(product_presentation)
      result.concat(")")
      result.concat(self.class.whitespace(@columns - 3 - product_presentation.size - description.size - price_presentation.size))
      result.concat("-");
      result.concat(price_presentation);
      result.concat("\n");
    end
    result.concat("\n")
    price_presentation = "%.2f" % receipt.total_price.to_f
    total = "Total: "
    whitespace = self.class.whitespace(@columns - total.size - price_presentation.size)
    result.concat(total, whitespace, price_presentation)
    return result.to_s
  end

  def print_item(item)
    price = "%.2f" % item.total_price
    quantity = self.class.present_quantity(item)
    name = item.product.product_name
    unit_price = "%.2f" % item.price

    whitespace_size = @columns - name.size - price.size
    line = name + self.class.whitespace(whitespace_size) + price + "\n"

    if item.quantity != 1
      line += "  " + unit_price + " * " + quantity + "\n"
    end
    line
  end

  def self.present_quantity(item)
    return Kata::UnitOfMeasure::EACH == item.product.unit_of_measure ? '%x' % item.quantity.to_i : '%.3f' % item.quantity
  end

  def self.whitespace(whitespace_size)
    ' ' * whitespace_size
  end

end
