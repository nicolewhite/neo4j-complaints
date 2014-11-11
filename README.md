consumer_complaints
===================

# Download

Download a dataset size that you think your machine can handle. We'll be exploring these in text editors / Excel, so **be sure to choose a size that will not lock up your machine when you try to open it**.

* [Large dataset, 304k rows](https://www.dropbox.com/s/4huddfi3yi0difd/consumer_complaints_304k.csv?dl=0)
* [Medium dataset, 100k rows](https://www.dropbox.com/s/b8ym4bw2s38xkpr/consumer_complaints_100k.csv?dl=0)
* [Small dataset, 30k rows](https://www.dropbox.com/s/1vw5h86kk8bcklw/consumer_complaints_30k.csv?dl=0)
* [X-Small dataset, 1k rows](https://www.dropbox.com/s/kahvm0x4mxgpk58/consumer_complaints_1k.csv?dl=0)

Source: http://catalog.data.gov/dataset/consumer-complaint-database

The raw .csv file has been cleaned slightly in `clean.R`, along with randomly sampled to create the smaller datasets.

# Model

Navigate to Alistair Jones's [arrow tool](http://www.apcjones.com/arrows/) to follow along with the modeling process.

# Import

We'll be writing the import queries together, but if you get lost or simply want to copy-paste, the 'answer key' is in `LOAD_CSV.txt`.

# Query

We'll also be doing some post-import exploration together, but some example queries are located in `example_queries.txt`.

# Lab

In the .csv, there is a column for the state in which the complaint was filed. Add this to the graph in any way you see fit. For example, you could decide to set a property on the Complaint node. Or, you might decide to create State nodes that are connected to the Complaint nodes.