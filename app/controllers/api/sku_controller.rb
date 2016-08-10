class Api::SkuController < ApplicationController
  require 'json'
  def index   
    #SKUS
    #skus = "978-0802412706,978-1594153204,978-1594631870"
    skus = params[:skus]

    gp_response = HTTParty.post("https://app.skuvault.com/api/products/getProducts", :query =>{:ProductSKUs => skus,:UserToken => "rU+wISuzqhzmJI2y5A0I3QX6bdmBB4lXpqeQtDk1ukM=", :TenantToken => "lxe4jjI1279ozpNWB9gecweAFl12kU+gngKjmL1ZNCg=", :format => "json"})
    #render json: JSON.pretty_generate(gp_response)
    title = []
    onhand= []
    pending = []
    available = []
    previous_p = "";
    gp_response['Products'].each do |p|
    	if(previous_p != p['Description'])
    		title.append(p['Description'])  
    		onhand.append(p['QuantityOnHand'])    		
    		pending.append(p['QuantityPending'])		
    		available.append(p['QuantityAvailable'])
    	end
    	previous_p = p['Description']
    end
    
    my_object = { :title => title, :skus => skus.split(","), :onhand => onhand, :pending => pending, :available => available}
	render json: my_object.to_json, :callback => params[:callback]
  end
end
