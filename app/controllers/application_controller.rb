class ApplicationController < ActionController::Base
  def index
	render html: "Test Page"
  end
end
