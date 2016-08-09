class Api::SkuController < ApplicationController
  require 'json'
  def index   
    #SKUS
    #skus = "978-0802412706,978-0842360241,978-0986366703,978-0986366710,978-1400324347,978-0990351405,978-1414398044,978-1433548406,978-1433679599,978-1481866880,978-1490907550,978-1490925387,978-1589975385,978-1594153204,978-1594631870"
    skus = params[:skus]

    gp_response = HTTParty.post("https://app.skuvault.com/api/products/getProducts", :query =>{:ProductSKUs => skus,:UserToken => "rU+wISuzqhzmJI2y5A0I3QX6bdmBB4lXpqeQtDk1ukM=", :TenantToken => "lxe4jjI1279ozpNWB9gecweAFl12kU+gngKjmL1ZNCg=", :format => "json"})
    #render json: JSON.pretty_generate(gp_response)
    title = []
    onhand= []
    pending = []
    previous_p = "";
    gp_response['Products'].each do |p|
    	if(previous_p != p['Description'])
    		title.append(p['Description'])  
    		onhand.append(p['QuantityOnHand'])    		
    		pending.append(p['QuantityPending'])
    	end
    	previous_p = p['Description']
    end
    
    my_object = { :title => title, :skus => skus.split(","), :onhand => onhand, :pending => pending}
	render json: my_object.to_json, :callback => params[:callback]
  end
end
