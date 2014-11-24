# consumer_complaints

This code accompanies the webinar [Using LOAD CSV in the Real World](http://watch.neo4j.org/video/112447027).

Things you need:

* Download `Consumer_Complaints.csv` [here](http://catalog.data.gov/dataset/consumer-complaint-database). Note that your .csv file might have more rows than mine did; they appear to update the data regularly.
* Find the arrows tool [here](http://www.apcjones.com/arrows/#).

Things you optionally need:

* [Sublime Text 2](http://www.sublimetext.com/2) (the editor used in the webinar) along with the [Cypher plugin](https://github.com/kollhof/sublime-cypher).

The Cypher code for reproducing the import is located in `LOAD_CSV.cql`. A handful of example queries for asking questions of the data are located in `example_queries.cql`.

**Important**
Note that this data import was done on a 16GB machine. If you have less RAM and particularly if you are on Windows, please see these blog posts:

* http://jexp.de/blog/2014/06/load-csv-into-neo4j-quickly-and-successfully/
* http://www.markhneedham.com/blog/2014/10/23/neo4j-cypher-avoiding-the-eager/
* http://jexp.de/blog/2014/10/load-cvs-with-success/

