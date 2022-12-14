class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    if current_sale 
      discount = 1 - current_sale.percent_off * 0.01
      (enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum * discount).round()
    else
      enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
    end
  end
  helper_method :cart_subtotal_cents


  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to '/sessions/new' unless current_user
  end

  def current_sale
    @current_sale ||= Sale.find_by("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current)
  end
  helper_method :current_sale

end
