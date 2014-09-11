#create basic tables in DB 

require_relative 'db_connect'

DB.create_table(:partial_queries) do
    primary_key :id
    String  :name, :null=>false
end

DB.create_table(:full_queries) do
    primary_key :id
    String  :name,  :null=> false
    Integer :score, :null=> false
end

DB.create_join_table(:partial_id=>:partial_queries, :full_id=>:full_queries)
