/*
================================================================================
LeetCode Problem: 595. Big Countries
Link: https://leetcode.com/problems/big-countries/
Difficulty: Easy
Architectural Concept: Predicate Evaluation with Disjunction (WHERE ... OR) & Indexing Considerations
================================================================================

Problem Summary:
A country is big if:
1. It has an area of at least three million (i.e., 3,000,000 km2), or
2. It has a population of at least twenty-five million (i.e., 25,000,000).

Write a solution to find the name, population, and area of the big countries.
Return the result table in any order.

Database Schema:
Table: World
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | bigint  |
+-------------+---------+
- name is the primary key for this table.
- Each row of this table gives information about the country's name, continent, area, population, and GDP.

Technical Insight:
- Standard approach uses simple row filtering with the OR logical operator.
- Performance note: In large-scale tables, "OR" across two different indexed columns
  might lead to an Index Scan or Table Scan. An alternative using UNION can sometimes
  allow independent Index Seeks depending on the optimizer.
*/
