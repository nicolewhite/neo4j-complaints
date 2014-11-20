// Top types of responses that are disputed.
MATCH (r:Response)-[:TO {disputed:true}]->(:Complaint)
RETURN r.name AS response, COUNT(*) AS count
ORDER BY count DESC

// Companies with the most disputed responses.
MATCH (:Response)-[:TO {disputed:true}]->(complaint:Complaint)
MATCH (complaint)-[:AGAINST]->(company:Company)
RETURN company.name AS company, COUNT(*) AS count
ORDER BY count DESC
LIMIT 10

// All issues.
MATCH (i:Issue)
RETURN i.name AS issue
ORDER BY issue

// All sub-issues within the 'communication tactics' issue.
MATCH (i:Issue {name:'COMMUNICATION TACTICS'})
MATCH (sub:SubIssue)-[:IN_CATEGORY]->(i)
RETURN sub.name AS subissue
ORDER BY subissue

// Top products and sub-products associated with the obscene / abusive language sub-issue.
MATCH (subIssue:SubIssue {name:'USED OBSCENE/PROFANE/ABUSIVE LANGUAGE'})
MATCH (complaint:Complaint)-[:WITH]->(subIssue)
MATCH (complaint)-[:ABOUT]->(p:Product)
OPTIONAL MATCH (complaint)-[:ABOUT]->(sub:SubProduct)
RETURN p.name AS product, sub.name AS subproduct, COUNT(*) AS count
ORDER BY count DESC

// Top company associated with the obscene / abusive language sub-issue.
MATCH (subIssue:SubIssue {name:'USED OBSCENE/PROFANE/ABUSIVE LANGUAGE'})
MATCH (complaint:Complaint)-[:WITH]->(subIssue)
MATCH (complaint)-[:AGAINST]->(company:Company)
RETURN company.name AS company, COUNT(*) AS count
ORDER BY count DESC
LIMIT 10

// Top product, issue combinations with disputed responses at Wells Fargo.
MATCH (wf:Company {name:'WELLS FARGO'})
MATCH (complaint:Complaint)-[:AGAINST]->(wf)
MATCH (:Response)-[:TO {disputed:true}]->(complaint)
MATCH (complaint)-[:ABOUT]->(p:Product)
MATCH (complaint)-[:WITH]->(i:Issue)
RETURN p.name AS product, i.name AS issue, COUNT(*) AS count
ORDER BY count DESC

// Sub-products that belong to multiple product categories.
MATCH (sub:SubProduct)-[:IN_CATEGORY]->(p:Product)
WITH sub, COLLECT(p) AS products
WHERE LENGTH(products) > 1
RETURN sub, products

// Sub-issues that belong to multiple issue categories.
MATCH (sub:SubIssue)-[:IN_CATEGORY]->(i:Issue)
WITH sub, COLLECT(i) AS issues
WHERE LENGTH(issues) > 1
RETURN sub, issues