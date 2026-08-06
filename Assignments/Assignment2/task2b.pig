/* TASK 2: Count number of customers in each type membership tier (SILVER, GOLD, PLATINUM). */
/* File Task2b.pig used for counting customers has GOLD membership tier. */
/* Store data in variable named loyalty, use '|' to field delimiter and define columns. */
loyalty = LOAD '/home/training/training_materials/analyst/exercises/data_mgmt/loyalty_data.txt' USING PigStorage('|')
  AS (Customer_ID:chararray, First_Name:chararray, Last_Name:chararray, Email:chararray,
      Membership_Tier:chararray, Phone_Number:chararray, transactions:chararray, Account_Summary:chararray);
/* Filter customers have membership tier is GOLD. */
gold_members = FILTER loyalty BY Membership_Tier == 'GOLD';
/* Combine group belongs to GOLD membership tier. */
gold_grouped = GROUP gold_members ALL;
/* Store the result. */
gold_result = FOREACH gold_grouped GENERATE CONCAT('Number of customers have GOLD membership tier is:',(chararray)COUNT(gold_members)) AS output_message;
/* Throws the result to terminal screen. */
DUMP gold_result;
