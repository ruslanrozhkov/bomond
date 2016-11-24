@product.orders.each do |order|
json.extract! order, :id, :name, :email, :pay_type, :created_at, :updated_at
  order.line_items.each do |item|
    json.extract! item, :quantity, :price
  end
end