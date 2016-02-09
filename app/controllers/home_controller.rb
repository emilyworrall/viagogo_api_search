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

    @category = []
    i = 0
    while i < 10 do
      if search_results.items[i] == nil
        break
      end
      i += 1
      next if search_results.items[i - 1].links['searchresult:category'] == nil
      @category << api.object_from_response(GogoKit::Category,
                                            GogoKit::CategoryRepresenter,
                                            :get,
                                            search_results.items[i - 1].links['searchresult:category'].href,
                                            nil)
    end
  end
end
