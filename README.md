Instant Search
==============

##Autocomplete System

Main Endpoint: http://instantsearch-env-vpkqa9a53j.elasticbeanstalk.com/s

Bonus Endpoint: http://instantsearch-env-vpkqa9a53j.elasticbeanstalk.com/keyword

__Params__
* `q` the string to be searched
* `limit` the limit to the results (useful where there are a lot of results)

##Implementation notes

These app utilizes [Sinatra](http://www.sinatrarb.com/) as a framework for the
API. The instance and the database are running off 
[Amazon's Elastic Beanstalk](http://aws.amazon.com/elasticbeanstalk/) and
[Amazon's Relational Database Server](http://aws.amazon.com/rds/).

## Two Approaches

When I started approaching this problem, the obvious (naïve?) solution to this
problem was to super de-normalize the data, essentially have a single document in
a NoSQL database that had all the possible answers for the characters types. For
example, the query "This is a test" would be broken down into the following
lists:

```
T
Th
Thi
This
This 
This i
This is
This is
This is a
This is a
This is a t
This is a te
This is a tes
This is a test
```

This idea was cool and I spent a fair amount of time pursuing this. Eventually,
I decided to go with RDS instead of DynamoDB because of cost (each table would
require its own read/write unit, which was going to be prohibitively expensive).
With RDS, I made two main tables and a join table. The first table consisted of 
partial queries of the kind shown above, while the second table contained 
completed queries and their weighted scores. This ended up requiring a nasty 
triple join, but I was able to make it work. The real cost of this is the cost 
of pre-loading all the partial queries, full queries, and joins into the DB. In 
fact, this process (which is handled by a script in the`script` dir) had not 
completed by the time I finished the code proper. This is because each record 
required a non-trivial amount of work to complete this approach. To see the 
result of this approach, use the main endpoint.

The bonus endpoint uses a different technique, one that would require less data
in the DB. The RDS instance I used was backed by MySQL. MySQL has some nice 
fuzzy string matching algorithms that are quite fast and would return any query
that contained the search parameter as a substring. This had another interesting
effect: the search results tended to be more relevant. Rather that looking at
just the beginning of each query, the entire contents of the query was considered.
I liked the results of this approach much better, so I included it as a bonus.
