/* TASK 2: Count number of customers in each type of membership tier(SILVER, GOLD, PLATINUM. */
/* File Task2a.pig used for count customers has SILVER membership tier. */
/* Create varible named loyalty to store data, split field table with '|', and define columns. */
loyalty = LOAD '/home/training/training_materials/analyst/exercises/data_mgmt/loyalty_data.txt' USING PigStorage('|')
  AS (Customer_ID:chararray, First_Name:chararray, Last_Name:chararray, Email:chararray,
      Membership_Tier:chararray, Phone_Number:chararray, Transactions:chararray, Account_Summary:chararray);
/* Filter customers have membership tier is SILVER. */
silver_members = FILTER loyalty BY Membership_Tier == 'SILVER';
/* Combine group belongs to customer SILVER membership tier. */
silver_grouped = GROUP silver_members ALL;
/* Store the result. */
silver_result = FOREACH silver_grouped GENERATE CONCAT('Number of customers have SILVER membership tier:',(chararray)COUNT(silver_members)) AS output_message;
/* Returns result to terminal screen. */
DUMP silver_result; 
