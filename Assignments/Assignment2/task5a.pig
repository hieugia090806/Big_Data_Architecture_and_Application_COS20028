/* TASK 5: Calculate the average total spend for each membership tier. Then, store the result in A2_2025_Q2. */
/* File task5a.pig used for calculating total and average total_spend of membership SILVER. */
/* Load source data named loyalty_data.txt. */
loyalty = LOAD '/home/training/training_materials/analyst/exercises/data_mgmt/loyalty_data.txt' USING PigStorage('|')
  AS (Customer_ID:chararray, First_Name:chararray, Last_Name:chararray, Email:chararray,
     Membership_Tier:chararray, Phone_Number:chararray, Transactions:chararray, Account_Summary:chararray);
/* Split Account_Summary column to take spend column (Question/Task 3). */
A2_2025_Q3 = FOREACH loyalty GENERATE Customer_ID, First_Name, Last_Name, Email, Membership_Tier, Phone_Number, Transactions,
             (int)STRSPLIT(Account_Summary,',').$0 AS Points:int, (double)STRSPLIT(Account_Summary,',').$1 AS Spend:double,
             (int)STRSPLIT(Account_Summary,',').$2 AS Purchases:int, (double)STRSPLIT(Account_Summary,',').$3 AS Lifetime_Value:double;
/* Filter customers has SILVER membership tier. */
silver_customers = FILTER A2_2025_Q3 BY Membership_Tier == 'SILVER';
/* Group SILVER membership tie. */
silver_grouped = GROUP silver_customers ALL;
/* Calculate SUM and AVERAGE. */
silver_total_spend = FOREACH silver_grouped GENERATE CONCAT('Total spend of SILVER customer memebrship tier is:',(chararray)SUM(silver_customers.Spend)) AS output_message;
silver_average_spend = FOREACH silver_grouped GENERATE CONCAT('Average spend of SILVER customer membership tier is:',(chararray)AVG(silver_customers.Spend)) AS output_messge;
A2_2025_Q5_5a = silver_total_spend;
A2_2025_Q5_5b = silver_average_spend;
/* Throws result to terminal screen.  */
DUMP A2_2025_Q5_5a;
DUMP A2_2025_Q5_5b;
/* Store. */
STORE A2_2025_Q5_5a INTO '/home/training/workspace/assignment2/A2_2025_Q5_5a' USING PigStorage('|');
STORE A2_2025_Q5_5b INTO '/home/training/workspace/assignment2/A2_2025_Q5_5b' USING PigStorage('|');
