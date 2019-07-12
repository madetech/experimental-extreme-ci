class Kata::ReceiptPrinter

  def initialize(columns = 40)
    @columns = columns
  end

  def print_receipt(receipt)
    result = ""
    for item in receipt.items do
      result += print_item(item)
    end

    for discount in receipt.discounts do
      result += print_discount(discount)
    end

    result += "\n"

    result += print_total(receipt)

    return result
  end

  def print_total(receipt)
    price_presentation = "%.2f" % receipt.total_price.to_f
    total = "Total: "
    whitespace = self.class.whitespace(@columns - total.size - price_presentation.size)
    "#{total}#{whitespace}#{price_presentation}"
  end

  def print_discount(discount)
    product_presentation = discount.product.product_name
    price_presentation = "%.2f" % discount.discount_amount
    description = discount.description
    whitespace = self.class.whitespace(@columns - 3 - product_presentation.size - description.size - price_presentation.size)
    "#{description}(#{product_presentation})#{whitespace}-#{price_presentation}\n"
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
