export FILEPATH=file:///Users/nicolewhite/Consumer_Complaints.csv

// Complaints, companies, responses.

	// Uniqueness constraints.
CREATE CONSTRAINT ON (c:Complaint) ASSERT c.id IS UNIQUE;
CREATE CONSTRAINT ON (c:Company) ASSERT c.name IS UNIQUE;
CREATE CONSTRAINT ON (r:Response) ASSERT r.name IS UNIQUE;

	// Load.
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM {FILEPATH} AS line
WITH DISTINCT line, SPLIT(line.`Date received`, '/') AS date
WHERE line.`Company response to consumer` IS NOT NULL AND
      line.Company IS NOT NULL

CREATE (complaint:Complaint { id: TOINT(line.`Complaint ID`) })
SET complaint.year = TOINT(date[2]),
    complaint.month = TOINT(date[0]),
    complaint.day = TOINT(date[1])

MERGE (company:Company { name: UPPER(line.Company) })
MERGE (response:Response { name: UPPER(line.`Company response to consumer`) })

CREATE (complaint)-[:AGAINST]->(company)
CREATE (response)-[r:TO]->(complaint)

SET r.timely = CASE line.`Timely response?` WHEN 'Yes' THEN true ELSE false END,
    r.disputed = CASE line.`Consumer disputed?` WHEN 'Yes' THEN true ELSE false END
;

// Products, issues.

	// Uniqueness constraints.
CREATE CONSTRAINT ON (p:Product) ASSERT p.name IS UNIQUE;
CREATE CONSTRAINT ON (i:Issue) ASSERT i.name IS UNIQUE;

	// Load.
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM {FILEPATH} AS line
WITH line
WHERE line.Product IS NOT NULL AND
      line.Issue IS NOT NULL

MATCH (complaint:Complaint { id: TOINT(line.`Complaint ID`) })

MERGE (product:Product { name: UPPER(line.Product) })
MERGE (issue:Issue {name: UPPER(line.Issue) })

CREATE (complaint)-[:ABOUT]->(product)
CREATE (complaint)-[:WITH]->(issue)
;

// Sub issues, sub products.

	// Uniqueness constraints.
CREATE CONSTRAINT ON (s:SubProduct) ASSERT s.name IS UNIQUE;
CREATE CONSTRAINT ON (s:SubIssue) ASSERT s.name IS UNIQUE;

	// Load.
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM {FILEPATH} AS line
WITH line 
WHERE line.`Sub-issue` <> '' AND
      line.`Sub-issue` IS NOT NULL

MATCH (complaint:Complaint { id: TOINT(line.`Complaint ID`) })
MATCH (complaint)-[:WITH]->(issue:Issue)

MERGE (subIssue:SubIssue { name: UPPER(line.`Sub-issue`) })
MERGE (subIssue)-[:IN_CATEGORY]->(issue)
CREATE (complaint)-[:WITH]->(subIssue)
;

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS
FROM {FILEPATH} AS line
WITH line 
WHERE line.`Sub-product` <> '' AND
      line.`Sub-product` IS NOT NULL

MATCH (complaint:Complaint { id: TOINT(line.`Complaint ID`) })
MATCH (complaint)-[:ABOUT]->(product:Product)

MERGE (subProduct:SubProduct { name: UPPER(line.`Sub-product`) })
MERGE (subProduct)-[:IN_CATEGORY]->(product)
CREATE (complaint)-[:ABOUT]->(subProduct)
;
