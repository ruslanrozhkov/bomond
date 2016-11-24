class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id, product_price)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
    #LineItem.update(current_item.id, price: product_price)
    current_item.price = product_price
    current_item
  end

  def total_price
    line_items.to_a.sum {|item| item.total_price}
  end

  def decrease(line_item_id)
    current_item = line_items.find(line_item_id)
    if current_item.quantity > 1
      current_item.quantity -= 1
    else
      current_item.destroy
    end
    current_item
  end

end
