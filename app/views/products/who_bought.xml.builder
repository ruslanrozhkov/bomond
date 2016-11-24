xml.instruct!
@product.orders.each do |order|
  xml.order do
    xml.id order.id
    xml.addres order.addres
    xml.item do
    order.line_items.each do |item|
      xml.product item.product.title
      xml.quantity item.quantity
      xml.price item.price
      end
    end
    xml.total do

    end
  end
end