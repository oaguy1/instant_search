require 'sequel'

DB = Sequel.connect(
    :adapter => 'mysql2', 
    :user => ENV.fetch('mysql_user'), 
    :host => ENV.fetch('mysql_url'),
    :port => ENV.fetch('mysql_port'),
    :database => ENV.fetch('mysql_db'),
    :password=> ENV.fetch('mysql_password')
)
