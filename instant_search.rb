require 'sinatra'
require 'json'
require_relative 'db/db_connect'

get '/' do
    "Instant Search, use the RESTful API to find search suggestions"
end

get '/s' do
    db_query = params[:q]
    results = DB["
        SELECT f.name, f.score
            FROM partial_queries p 
                JOIN full_queries_partial_queries fp 
                    ON p.id = fp.partial_id 
                JOIN full_queries f 
                    ON f.id = fp.full_id 
            WHERE p.name = ? order by f.score desc", db_query]

    if params[:limit]
        limit = params[:limit].to_i
        data = results.limit(limit).collect { |result| result[:name] }
    else
        data = results.all.collect { |result| result[:name] }
    end

    jsn = { :q => db_query, :d => data }.to_json
end
