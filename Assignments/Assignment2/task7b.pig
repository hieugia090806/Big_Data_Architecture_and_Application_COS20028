/* TASK 7: Sum the total points earned by customers in each membership tier. Then, store result in A2_2025_Q7. */
/* File task7b.pig used for summing total points earned by SILVER customers membership tier. */
/* Load data source. */
loyalty = LOAD '/home/training/training_materials/analyst/exercises/data_mgmt/loyalty_data.txt' USING PigStorage('|')
  AS (Customer_ID:chararray, First_Name:chararray, Last_Name:chararray, Email:chararray,
      Membership_Tier:chararray, Phone_Number:chararray, Transactions:chararray, Account_Summary:chararray);
/* From Question 3(Task 3). */
A2_2025_Q3 = FOREACH loyalty GENERATE Customer_ID, First_Name, Last_Name, Email, Membership_Tier, Phone_Number, Transactions,
             (int)STRSPLIT(Account_Summary,',').$0 AS Points:int, (double)STRSPLIT(Account_Summary,',').$1 AS Spend:double,
             (int)STRSPLIT(Account_Summary,',').$2 AS Purchases:int, (double)STRSPLIT(Account_Summary,',').$3 AS Lifetime_Value:double;	
/* Filter and group SILVER members. */
silver_members = FILTER A2_2025_Q3 BY Membership_Tier == 'SILVER';
silver_grouped = GROUP silver_members ALL;
/* Count total points. */
silver_point = FOREACH silver_grouped GENERATE CONCAT('Total points of SILVER membership tier is:',(chararray)SUM(silver_members.Points)) AS output_message;
/* Throws result to terminal. */
DUMP silver_point;
/* Store result. */
A2_2025_Q7_7b = silver_point;
STORE A2_2025_Q7_7b INTO '/home/training/workspace/assignment2/A2_2025_Q7_7b' USING PigStorage('|'); 
