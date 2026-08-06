/* TASK 8: COunt how many customers use each email domain (e.g, gmail.com, example.com). Then, store result in A2_2025_Q8. */
/* Load data source. */
loyalty = LOAD '/home/training/training_materials/analyst/exercises/data_mgmt/loyalty_data.txt' USING PigStorage('|')
  AS (Customer_ID:chararray, First_Name:chararray, Last_Name:chararray, Email:chararray,
      Membership_Tier:chararray, Phone_Number:chararray, Transactions:chararray, Account_Summary:chararray);
/* From Question 3(Task 3). */
A2_2025_Q3 = FOREACH loyalty GENERATE Customer_ID, First_Name, Last_Name, (chararray)STRSPLIT(Email,'@').$1 AS domain:chararray,
             Membership_Tier, Phone_Number, Transactions,
             (int)STRSPLIT(Account_Summary,',').$0 AS Points:int, (double)STRSPLIT(Account_Summary,',').$1 AS Spend:double,
             (int)STRSPLIT(Account_Summary,',').$2 AS Purchases:int, (double)STRSPLIT(Account_Summary,',').$3 AS Lifetime_Value:double;	
/* Group by DOMAIN. */
grouped_by_domain = GROUP A2_2025_Q3 BY domain;
/* Return result. */
A2_2025_Q8 = FOREACH grouped_by_domain GENERATE group AS domain,COUNT(A2_2025_Q3) AS total_customers;
/*Throws the result. */
DUMP A2_2025_Q8;
/* Store result. */
STORE A2_2025_Q8 INTO '/home/training/workspace/assignment2/A2_2025_Q8' USING PigStorage('|'); 
