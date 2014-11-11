options(stringsAsFactors=F)
library(dplyr)

# Consumer_Complaints.csv downloaded from http://catalog.data.gov/dataset/consumer-complaint-database
complaints = read.csv("Consumer_Complaints.csv")

# Remove unnecessary columns.
complaints = select(complaints, -ZIP.code, -Submitted.via, -Date.sent.to.company)

# Rename columns.
names(complaints) = c("ComplaintID", 
                      "Product", 
                      "SubProduct", 
                      "Issue", 
                      "SubIssue", 
                      "State", 
                      "DateReceived", 
                      "Company", 
                      "CompanyResponse", 
                      "TimelyResponse", 
                      "ConsumerDisputed")

# Remove complaints with missing values in the Issue column. Removes 2 rows.
complaints = filter(complaints, Issue != "")

# Format the date received column.
complaints$DateReceived = as.Date(complaints$DateReceived, format = "%m/%d/%Y")

# Replace empty disputed with 'No'.
complaints$ConsumerDisputed = ifelse(complaints$ConsumerDisputed == "Yes", "Yes", "No")

# Write clean data.
write.csv(complaints, file = "consumer_complaints_310k.csv", row.names = F)

medium = complaints[sample(1:nrow(complaints), 100000), ]
small = complaints[sample(1:nrow(complaints), 30000), ]
xsmall = complaints[sample(1:nrow(complaints), 1000), ]

write.csv(medium, file = "consumer_complaints_100k.csv", row.names = F)
write.csv(small, file = "consumer_complaints_30k.csv", row.names = F)
write.csv(xsmall, file = "consumer_complaints_1k.csv", row.names = F)
