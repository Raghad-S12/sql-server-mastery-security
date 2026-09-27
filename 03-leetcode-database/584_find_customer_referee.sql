/*
================================================================================
LeetCode Problem: 584. Find Customer Referee
Link: https://leetcode.com/problems/find-customer-referee/
Difficulty: Easy
Architectural Concept: 3-Valued Logic (3VL) & Handling NULLs in WHERE Clauses
================================================================================

Problem Summary:
Find the names of the customer that are not referred by the customer with id = 2.
Return the result table in any order.

Database Schema:
Table: Customer
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+

Technical Insight (3VL Trap):
- Writing "WHERE referee_id <> 2" will automatically filter out rows where referee_id IS NULL.
- In SQL 3VL: (NULL <> 2) evaluates to UNKNOWN.
- The WHERE clause only accepts expressions that evaluate strictly to TRUE.
- Therefore, we must explicitly account for NULLs.
*/

-- Solution 1: Explicit OR IS NULL (ANSI Standard)
SELECT name
FROM Customer
WHERE referee_id <> 2 
   OR referee_id IS NULL;

-- Solution 2: Alternative using ISNULL / COALESCE (T-SQL / ANSI)
-- SELECT name
-- FROM Customer
-- WHERE COALESCE(referee_id, 0) <> 2;
