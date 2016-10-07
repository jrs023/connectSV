class Api::SkuController < ApplicationController
  require 'json'
  def index   
    #SKUS
    #skus =   
    skus = params[:skus]
    title = []
    onhand= []
    pending = []
    available = []
    incoming = []
    reorder = []
    previous_p = "";
    
	if skus.split(',').size() > 110
		total = skus.split(',').size()
		start_point = 0;
		end_point = 110;
		t = skus.split(',')
		while(start_point != end_point)
			temp = t[start_point..end_point]
			temp_skus = temp.join(",")
			
			gp_response = HTTParty.post("https://app.skuvault.com/api/products/getProducts", :query =>{:ProductSKUs => temp_skus,:UserToken => "rU+wISuzqhzmJI2y5A0I3QX6bdmBB4lXpqeQtDk1ukM=", :TenantToken => "lxe4jjI1279ozpNWB9gecweAFl12kU+gngKjmL1ZNCg=", :format => "json"})
			gp_response['Products'].each do |p|
				if(previous_p != p['Description'])
					title.append(p['Description'])  
					onhand.append(p['QuantityOnHand'])    		
					pending.append(p['QuantityPending'])		
					available.append(p['QuantityAvailable'])
					incoming.append(p['QuantityIncoming'])
					reorder.append(p['ReorderPoint'])
				end
				previous_p = p['Description']
			end
			start_point = end_point
			if(end_point + 110 > total)
				end_point = start_point + (total - end_point)+1
			else
				end_point = end_point+110
			end
			
			puts start_point.to_s + " " + end_point.to_s + " " + gp_response['Products'].size.to_s
		end
	else
		 gp_response = HTTParty.post("https://app.skuvault.com/api/products/getProducts", :query =>{:ProductSKUs => skus,:UserToken => "rU+wISuzqhzmJI2y5A0I3QX6bdmBB4lXpqeQtDk1ukM=", :TenantToken => "lxe4jjI1279ozpNWB9gecweAFl12kU+gngKjmL1ZNCg=", :format => "json"})
		#render json: JSON.pretty_generate(gp_response)
		gp_response['Products'].each do |p|
			if(previous_p != p['Description'])
				title.append(p['Description'])  
				onhand.append(p['QuantityOnHand'])    		
				pending.append(p['QuantityPending'])		
				available.append(p['QuantityAvailable'])
				incoming.append(p['QuantityIncoming'])
				reorder.append(p['ReorderPoint'])
			end
			previous_p = p['Description']
		end
	end		 
	    
	    
	my_object = { :title => title, :skus => skus.split(","), :onhand => onhand, :pending => pending, :available => available, :incoming => incoming, :reorder => reorder}
	render json: my_object.to_json, :callback => params[:callback]
  end
end
