#! /bin/ruby

################################################################################
# This script takes in a text file with queries and imports it into DynmoDB
# for use by the Sinatra web app
################################################################################

require 'aws-sdk'

def componentize(line_string)
    line_string.split(/[\t|\n]/)
end

def gen_table_names(query_string)
    table_names = []
    current_name = ""

    query_string.to_s.each_char do |c|
        if c == ' '
            current_name += '%20'
        else
            current_name += c
        end
        table_names << current_name
    end

    table_names
end

file = File.open(ARGV[0])

query = "this is a test".gsub(/\s+/, '%20')

dynamo_db = AWS::DynamoDB.new
table = dynamo_db.tables.create(query, 1, 1)
puts table.exists?

#file.each_line do |line|
#    components = componentize line
#    tables = gen_table_names(components[0])
#    puts tables
#end
