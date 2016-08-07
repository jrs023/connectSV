class Api::SkuController < ApplicationController
  require 'json'
  def show   
    #SKUS
    #skus = "[978-1601424280,978-0802848000]"
    skus = params[:skus];

    gp_response = HTTParty.post("https://app.skuvault.com/api/products/getProducts", :query =>{:ProductSKUs => skus,:UserToken => "rU+wISuzqhzmJI2y5A0I3QX6bdmBB4lXpqeQtDk1ukM=", :TenantToken => "lxe4jjI1279ozpNWB9gecweAFl12kU+gngKjmL1ZNCg=", :format => "json"})
   
    title = []
    onhand= []
    pending = []
    gp_response['Products'].each do |p|
    	title.append(p['Description'])
    end
    gp_response['Products'].each do |p|
    	onhand.append(p['QuantityOnHand'])
    end
    gp_response['Products'].each do |p|
    	pending.append(p['QuantityPending'])
    end
    
    my_object = { :title => title, :skus => skus, :onhand => onhand, :pending => pending}
	render json: my_object.to_json, :callback => params[:callback]
  end
end
