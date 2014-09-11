##
# Unlike other spec file, this is testing the methods created for the uploading
# script
##

require 'spec_helper'

describe "#gen_table_names" do

    it 'returns an empty list when an empty string is passed in' do
        expect(gen_table_names("")).to eq []
    end

    it 'returns a list containing all the possible table names' do
        expected = [
            't',
            'te',
            'tes',
            'test'
        ]
         list = gen_table_names("test")
        
         expect(list).to match_array expected
    end

    it "should escpape spaces with '%20'" do
        list = gen_table_names("this is a test")
        expect(list).to include 'this%20'
    end

end


