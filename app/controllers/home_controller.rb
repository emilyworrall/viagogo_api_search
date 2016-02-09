require 'gogokit'
require 'json'

class HomeController < ApplicationController

  def index
  end

  def show
    api = GogoKit::Client.new(client_id: ENV['VIAGOGO_ID'],
                              client_secret: ENV['VIAGOGO_SECRET'])
    token = api.get_client_access_token
    api.access_token = token.access_token
    search_results = api.search(params[:search_term])
    render json: search_results
  end
end
