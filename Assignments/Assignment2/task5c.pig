/* TASK 5: Calculate the average total spend for each membership tier. Then, store the result in A2_2025_Q5. */
/* FIle task5c.pig used for calculating total and average spend of PLATINUM membership tier. */
loyalty = LOAD '/home/training/training_materials/analyst/exercises/data_mgmt/loyalty_data.txt' USING PigStorage('|')
  AS (Customer_ID:chararray, First_Name:chararray, Last_Name:chararray, Email:chararray,
      Membership_Tier:chararray, Phone_Number:chararray, Transactions:chararray, Account_Summary:chararray);

A2_2025_Q3 = FOREACH loyalty GENERATE Customer_ID, First_Name, Last_Name, Email, Membership_Tier, Phone_Number, Transactions, Account_Summary,
             (int)STRSPLIT(Account_Summary,',').$0 AS Points:int, (double)STRSPLIT(Account_Summary,',').$1 AS Spend:double,
             (int)STRSPLIT(Account_Summary,',').$2 AS Purchases:int, (double)STRSPLIT(Account_Summary,',').$3 AS Lifetime_Value:double;

platinum_customers = FILTER A2_2025_Q3 BY Membership_Tier == 'PLATINUM';
platinum_grouped = GROUP platinum_customers ALL;
platinum_total_spend = FOREACH platinum_grouped GENERATE CONCAT('Total spend of PLATINUM customer membership is:', (chararray)SUM(platinum_customers.Spend)) AS output_message;
platinum_average_spend = FOREACH platinum_grouped GENERATE CONCAT('Average spend of PLATINUM customer membership is:', (chararray)AVG(platinum_customers.Spend)) AS output_message;

A2_2025_Q5_5e = platinum_total_spend;
A2_2025_Q5_5f = platinum_average_spend;
STORE A2_2025_Q5_5e INTO '/home/training/workspace/assignment2/Q5_2025_Q5_5e' USING PigStorage('|');
STORE A2_2025_Q5_5f INTO '/home/training/workspace/assignment2/Q5_2025_Q5_5f' USING PigStorage('|');
