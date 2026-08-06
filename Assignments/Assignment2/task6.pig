/* TASK 6: Find customers have more than one phone number recorded and then save to A2_2025_Q6. */
/* Load source data. */
loyalty = LOAD '/home/training/training_materials/analyst/exercises/data_mgmt/loyalty_data.txt' USING PigStorage('|')
  AS (Customer_ID:chararray, First_Name:chararray, Last_Name:chararray, Email:chararray,
      Membership_Tier:chararray, Phone_Number:chararray, Transactions:chararray, Account_Summary:chararray);
/* Filter customers have more than 2 phone records. */
customers_multi_phone_number_records = FILTER loyalty BY Phone_Number MATCHES '.*,.*';
/* Create alias to store customers have more than 2 phone number records. */
A2_2025_Q6 = FOREACH customers_multi_phone_number_records GENERATE Customer_ID, First_Name, Last_Name,
                                                                   Email, Membership_Tier, Phone_Number;
/* Throws result to terminal screen. */
DUMP A2_2025_Q6;
/* Store result. */
STORE A2_2025_Q6 INTO '/home/training/workspace/assignment2/A2_2025_Q6' USING PigStorage('|');
