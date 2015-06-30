# consumer_complaints

This code accompanies the webinar [Using LOAD CSV in the Real World](http://watch.neo4j.org/video/112447027).

## Setup

* Download `Consumer_Complaints.csv` [here](http://catalog.data.gov/dataset/consumer-complaint-database). Note that your .csv file might have more rows than mine did; they appear to update the data regularly.

* Find the arrows tool [here](http://www.apcjones.com/arrows/#).

* [Sublime Text 2](http://www.sublimetext.com/2) (the editor used in the webinar) along with the [Cypher plugin](https://github.com/kollhof/sublime-cypher).

## Import

- Change line 1 of `load.cql` to point to the location of your `Consumer_Complaints.csv` file.
    - OSX and Unix: `file:///path/to/Consumer_Complaints.csv`
    - Windows: `file:C:/path/to/Consumer_Complaints.csv`

- Send `load.cql` to the `neo4j-shell`: `./bin/neo4j-shell -file load.cql`

**Important**
Note that this import was done on a 16GB machine. If you have less RAM and particularly if you are on Windows, please see these blog posts:

* http://jexp.de/blog/2014/06/load-csv-into-neo4j-quickly-and-successfully/
* http://www.markhneedham.com/blog/2014/10/23/neo4j-cypher-avoiding-the-eager/
* http://jexp.de/blog/2014/10/load-cvs-with-success/

Also note that in the original webinar, I split `Consumer_Complaints.csv` into separate files to deal with rows with empty strings. Since then, I've modified the script to only use `Consumer_Complaints.csv` but with empty strings filtered out for the subissues and subproducts:

```
FROM {FILEPATH} AS line
WITH line WHERE line.`Sub-issue` <> ''
```

```
FROM {FILEPATH} AS line
WITH line WHERE line.`Sub-product` <> ''
```

## Query

Run all the example queries:

```
./bin/neo4j-shell -file query.cql
```
