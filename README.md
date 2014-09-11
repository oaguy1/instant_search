Instant Search
==============

##Autocomplete System

Endpoint: http://instantsearch-env-vpkqa9a53j.elasticbeanstalk.com/s

__Params__
* `q` the string to be searched
* `limit` the limit to the results (useful where there are a lot of results)

##Implementation notes

These app utilizes [Sinatra](http://www.sinatrarb.com/) as a framework for the
API. The instance and the database are running off 
[Amazon's Elastic Beanstalk](http://aws.amazon.com/elasticbeanstalk/) and
[Amazon's Relational Database Server](http://aws.amazon.com/rds/).
