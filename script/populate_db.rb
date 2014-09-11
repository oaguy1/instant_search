#! /bin/ruby

################################################################################
# This script takes in a text file with queries and imports it into DynmoDB
# for use by the Sinatra web app
################################################################################

require 'aws-sdk'

ROOT_DIR = File.join(File.expand_path(File.dirname(__FILE__)), './..')
require File.join(ROOT_DIR, 'db/db_connect')

def componentize(line_string)
    line_string.split(/[\t|\n]/)
end

def gen_partial_queries(query_string)
    table_names = []
    current_name = ""

    query_string.to_s.each_char do |c|
        current_name += c
        table_names << current_name
    end

    table_names
end

file = File.open(ARGV[0])

file.each_line do |line|

    components = componentize line
    query_string = components[0]
    query_score = components[1]

    # create/get id of full query
    full_query = DB[:full_queries].where(:name => query_string).first
    full_query = full_query[:id] if full_query.is_a? Hash
    unless full_query
        full_query = DB[:full_queries].insert(
            :name => query_string,
            :score => query_score
        )
    end

    # find all partial queries and generate database entries for them
    partial_queries = gen_partial_queries(query_string)
    partial_queries.each do | partial|

        # create/get id of partial query
        partial_query = DB[:partial_queries].where(:name => partial).first
        partial_query = partial_query[:id] if partial_query.is_a? Hash
        unless partial_query
            partial_query = DB[:partial_queries].insert(:name => partial)
        end

        #adds partial and full queries to join table if it doesn't exist
        joined = DB[:full_queries_partial_queries].where(
            :partial_id => partial_query,
            :full_id => full_query
        ).first

        unless joined 
            DB[:full_queries_partial_queries].insert(
                :full_id => full_query,
                :partial_id => partial_query
            )
        end
    end
end
