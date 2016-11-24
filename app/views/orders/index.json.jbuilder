json.array!(@orders) do |order|
  json.extract! order, :id, :name, :addres, :email, :pay_type
  json.url order_url(order, format: :json)
end
