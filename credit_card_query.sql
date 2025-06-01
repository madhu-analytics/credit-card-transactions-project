SELECT * FROM credit_card_transcations LIMIT 1000;

-- Understanding the Data 

-- Data collected duration?
select min(transaction_date), max(transaction_date) from credit_card_transcations;

-- Different card types?
select distinct(card_type) from credit_card_transcations;

-- What are the different expenses?
select distinct(exp_type) from credit_card_transcations;

-- Different Cities?
select distinct(city) from credit_card_transcations;

-- Solving Questions

-- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends

with cte1 as(
select city, sum(amount) as total_spends
from credit_card_transcations
group by city), total_spent as (select sum(cast(amount as signed)) as total_amount from credit_card_transcations)

select cte1.*, total_amount, round((total_spends/total_amount)*100, 2) as percentage from cte1 , total_spent
order by total_spends desc
limit 5 








