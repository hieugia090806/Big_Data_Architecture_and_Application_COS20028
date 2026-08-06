/* TASK 2: Count number of customers in each membership tier(SILVER, GOLD, PLATINUM) */
/* File Task2c.pig used for counting customers has membership tier is PLATINUM. */
/* Create variable named loyalty to store, use '|' to field delimiter, and fedine column. */
loyalty = LOAD '/home/training/training_materials/analyst/exercises/data_mgmt/loyalty_data.txt' USING PigStorage('|')
  AS (Customer_ID:chararray, First_Name:chararray, Last_Name:chararray, Email:chararray,
      Membership_Tier:chararray, Phone_Number:chararray, Transactions:chararray, Account_Summary:chararray);
/* Filter customers has membership tier equals to PLATINUM. */
platinum_members = FILTER loyalty BY Membership_Tier == 'PLATINUM';
/* Group all PLATINUM membership tier. */
platinum_grouped = GROUP platinum_members ALL;
/* Store the result. */
platinum_result = FOREACH platinum_grouped GENERATE CONCAT('Number of customers have PLATINUM membership tier is:',(chararray)COUNT(platinum_members)) AS output_message;
/* Throws the result to terminal screen. */
DUMP platinum_result;

