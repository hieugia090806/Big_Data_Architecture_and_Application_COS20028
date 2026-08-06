/* TASK 7: Sum the total points earned by customers in each membership tier. Then, store result in A2_2025_Q7. */
/* File task7a.pig used for summing total points earned by GOLD customers membership tier. */
/* Load data source. */
loyalty = LOAD '/home/training/training_materials/analyst/exercises/data_mgmt/loyalty_data.txt' USING PigStorage('|')
  AS (Customer_ID:chararray, First_Name:chararray, Last_Name:chararray, Email:chararray,
      Membership_Tier:chararray, Phone_Number:chararray, Transactions:chararray, Account_Summary:chararray);
/* From TASK3. */
A2_2025_Q3 = FOREACH loyalty GENERATE Customer_ID, First_Name, Last_Name, Email, Membership_Tier, Phone_Number, Transactions,
             (int)STRSPLIT(Account_Summary,',').$0 AS Points:int, (double)STRSPLIT(Account_Summary,',').$1 AS Spend:double,
             (int)STRSPLIT(Account_Summary,',').$2 AS Purchases:int, (double)STRSPLIT(Account_Summary,',').$3 AS Lifetime_Value:double;
/* Group GOLD membership. */
gold_members = FILTER A2_2025_Q3 BY Membership_Tier == 'GOLD';
gold_grouped = GROUP gold_members ALL;
/* Count total points. */
gold_point = FOREACH gold_grouped GENERATE CONCAT('Total points of GOLD membership tier is:',(chararray)SUM(gold_members.Points)) AS output_message;
/* Throws result to terminal. */
DUMP gold_point;
/* Store result. */
A2_2025_Q7_7a = gold_point;
STORE A2_2025_Q7_7a INTO '/home/training/workspace/assignment2/A2_2025_Q7_7a' USING PigStorage('|');
