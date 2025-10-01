class Public::ShippingAddressesController < ApplicationController
  before_action :authenticate_customer!
end
