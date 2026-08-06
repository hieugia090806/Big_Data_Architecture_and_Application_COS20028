/* TASK 4: FInd top-5 customers with the highest lifetime value and store result in A2_2025_Q4. */
/* Load source data. */
loyalty = LOAD '/home/training/training_materials/analyst/exercises/data_mgmt/loyalty_data.txt' USING PigStorage('|')
  AS (Customer_ID:chararray, First_Name:chararray, Last_Name:chararray, Email:chararray,
      Membership_Tier:chararray, Phone_Number:chararray, Transactions:chararray, Account_Summary:chararray);
/* Task 3. */
A2_2025_Q3 = FOREACH loyalty GENERATE Customer_ID, First_Name, Last_Name, Email, Membership_Tier, Phone_Number, Transactions,
               (int)STRSPLIT(Account_Summary,',').$0 AS points:int, (double)STRSPLIT(Account_Summary,',').$1 AS spend:double,
               (int)STRSPLIT(Account_Summary,',').$2 AS purchases:int, (double)STRSPLIT(Account_Summary,',').$3 AS lifetime_value:double;
/* Order lifetime_value according to DESC. */
A2_2025_Q4_sorted = ORDER A2_2025_Q3 BY lifetime_value DESC;
/* Top 5 customers has lifetime_value highest. */
A2_2025_Q4 = LIMIT A2_2025_Q4_sorted 5;
/* Throws result to terminal screen. */
DUMP A2_2025_Q4;
/* Store. */
STORE A2_2025_Q4 INTO '/home/training/workspace/assignment2/A2_2025_Q4' USING PigStorage('|');
