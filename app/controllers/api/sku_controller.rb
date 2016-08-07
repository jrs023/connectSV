class Api::SkuController < ApplicationController
  
  def show
  
    #SKUS
    #skus = "[978-1601424280,978-0802848000]"
    skus = params[:skus]
    
    gp_response = HTTParty.post("https://app.skuvault.com/api/products/getProducts", :query =>{:ProductSKUs => skus,:UserToken => "rU+wISuzqhzmJI2y5A0I3QX6bdmBB4lXpqeQtDk1ukM=", :TenantToken => "lxe4jjI1279ozpNWB9gecweAFl12kU+gngKjmL1ZNCg=", :format => "json"})
   
    #render json: gp_response
    info = []
    
    title = []
    qonhand= []
    qpending = []
    gp_response['Products'].each do |p|
    	title.append(p['Description'])
    end
    gp_response['Products'].each do |p|
    	qonhand.append(p['QuantityOnHand'])
    end
    gp_response['Products'].each do |p|
    	qpending.append(p['QuantityPending'])
    end
    info.append(title)
    info.append(skus)
    info.append(qonhand)
    info.append(qpending)
    
	format.json{render :json => info}
  end
end
