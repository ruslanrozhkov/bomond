class Order < ActiveRecord::Base

  after_update :send_changed_ship_email, :if => :ship_date_changed?

  validates :name, :addres, :email, presence: true
  validates :pay_type, inclusion: PaymentType.names

  validates_each :pay_type do |model, attr, value|
    if !PaymentType.names.include?(value)
      model.errors.add(attr, 'Payment type not on the list')
    end
  end

  has_many :line_items, dependent: :destroy

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def send_changed_ship_email
    OrderNotifier.shipped(self).deliver
  end

end
