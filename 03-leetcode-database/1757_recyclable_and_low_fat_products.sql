/*
================================================================================
LeetCode Problem: 1757. Recyclable and Low Fat Products
Link: https://leetcode.com/problems/recyclable-and-low-fat-products/
Difficulty: Easy
Architectural Concept: Row-Level Filtering & Predicate Evaluation (WHERE with AND)
================================================================================

Problem Summary:
Write a solution to find the ids of products that are both low fat and recyclable.
Return the result table in any order.

Database Schema:
Table: Products
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| low_fats    | enum    |
| recyclable  | enum    |
+-------------+---------+
- product_id is the primary key for this table.
- low_fats is an ENUM of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
- recyclable is an ENUM of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.

Technical Insight:
- Simple predicate pushdown: Filters rows at the storage level using WHERE clause.
- Both predicates must evaluate strictly to TRUE using the logical operator AND.
*/
SELECT product_id FROM Products WHERE low_fats='Y' AND recyclable ='Y'
