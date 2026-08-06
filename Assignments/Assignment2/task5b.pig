/* Task 5: Calculate the average total spend for each membership tier. Then, store result in A2_2025_Q5. */
/* File task5b.pig used for calculating toal and average spend of GOLD membership tier. */
/* load source data. */
loyalty = LOAD '/home/training/training_materials/analyst/exercises/data_mgmt/loyalty_data.txt' USING PigStorage('|')
  AS (Customer_ID:chararray, First_Name:chararray, Last_Name:chararray, Email:chararray,
      Membership_Tier:chararray, Phone_Number:chararray, Transactions:chararray, Account_Summary:chararray);

A2_2025_Q3 = FOREACH loyalty GENERATE Customer_ID, First_Name, Last_Name, Email, Membership_Tier, Phone_Number, Transactions,
             (int)STRSPLIT(Account_Summary,',').$0 AS Points:int, (double)STRSPLIT(Account_Summary,',').$1 AS Spend:double,
             (int)STRSPLIT(Account_Summary,',').$2 AS Purchases:int, (double)STRSPLIT(Account_Summary,',').$3 AS Lifetime_Value:double;

gold_customers = FILTER A2_2025_Q3 BY Membership_Tier == 'GOLD';
gold_grouped = GROUP gold_customers ALL;
gold_total_spend = FOREACH gold_grouped GENERATE CONCAT('Total spend of GOLD customer membership tier is:', (chararray)SUM(gold_customers.Spend)) AS output_message;
gold_average_spend = FOREACH gold_grouped GENERATE CONCAT('Average spend of GOLD customer membership tier is:', (chararray)AVG(gold_customers.Spend)) AS output_message;

A2_2025_Q5_5c = gold_total_spend;
A2_2025_Q5_5d = gold_average_spend;
STORE A2_2025_Q5_5c INTO '/home/training/workspace/assignment2/A2_2025_Q5_5c' USING PigStorage('|');
STORE A2_2025_Q5_5d INTO '/home/training/workspace/assignment2/A2_2025_Q5_5d' USING PigStorage('|');
