/* TASK 3: Split the account_summary field into meaningful columns: points, spend, purchases, and lifetime_value. Then, store in A2_2025_Q3 */
/* Load data from file loyalty.txt. */
loyalty = LOAD '/home/training/training_materials/analyst/exercises/data_mgmt/loyalty_data.txt' USING PigStorage('|')
  AS (Customer_ID:chararray, First_Name:chararray, Last_Name:chararray, Email:chararray,
      Membership_Tier:chararray, Phone_Number:chararray, Transactions:chararray, Account_Summary:chararray);
/*Split Account_Summary field into points, spend, purchases, and lifetime_value and store into A2_2025_Q3. */
A2_2025_Q3 = FOREACH loyalty GENERATE Customer_ID, First_Name, Last_Name, Email, Membership_Tier, Phone_Number, Transactions,
               (int)STRSPLIT(Account_Summary,',').$0 AS points:int, (double)STRSPLIT(Account_Summary,',').$1 AS spend:double,
               (int)STRSPLIT(Account_Summary,',').$2 AS purchases:int, (double)STRSPLIT(Account_Summary,',').$3 AS lifetime_value:double;
/* Show cases first 10 lines of A2_2025_Q3. */
A2_2025_Q3_limited_10 = LIMIT A2_2025_Q3 10;
/* Throws result to the terminal. */
DUMP A2_2025_Q3_limited_10;
/* Recommendation: Store the A2_2025_Q3 into csv file. */
STORE A2_2025_Q3 INTO '/home/training/workspace/assignment2/A2_2025_Q3' USING PigStorage('|');

