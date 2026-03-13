#Total transactions

select count(*) as total_transactions
from fintech_transactions;

#Fraud rate

select (sum(fraudulent)/count(*))*100 as Fraud_rate_percent 
from fintech_transactions;

#average transaction

select avg(transaction_amount) as Avg_amount
from fintech_transactions;

#Fraud patterns by location
select location, count(*) as total_tx, sum(fraudulent) as fraud_count, (sum(fraudulent)/ count(*))*100 as fraud_rate
from fintech_transactions
group by location 
order by fraud_rate desc;

# fraud patterns by Device
select device_used, sum(fraudulent) as fraud_count
from fintech_transactions
group by device_used
order by fraud_count desc;

#fraud patterns by payment method
select payment_method, avg(transaction_amount) as average_amount, sum(fraudulent)as fraud_count
from fintech_transactions 
where fraudulent=1
group by payment_method;

#high risk users
select  user_id, sum(fraudulent) as fraud_count, avg(account_age)as Avg_age
from fintech_transactions
group by User_id
having fraud_count >0
order by fraud_count desc;

#time based
select time_of_transaction, count(*) as tx_count, sum(fraudulent) as fraud_count
from fintech_transactions
group by time_of_transaction
order by time_of_transaction;

#correlations 
select *
from fintech_transactions
where number_of_transactions_last_24H > 10 and fraudulent=1;

create view Fraud_Summary as
select location, payment_method, avg(transaction_amount) as Avg_Amount, sum(fraudulent) as Fraud_count 
from fintech_transactions
group by location, payment_method