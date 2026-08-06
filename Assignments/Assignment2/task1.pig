/* TASK 1: Load source data and count number of tuples. */
/* Create variable named loyalty to store dataset and using '|' as field delimiter. */
loyalty = LOAD '/home/training/training_materials/analyst/exercises/data_mgmt/loyalty_data.txt' USING PigStorage('|');
/* Drop all data toghether. */
loyalty_all = GROUP loyalty ALL;
/* Count number of tuples. */
total_tuples = FOREACH loyalty_all GENERATE COUNT(loyalty);
/* Returns result to terminal screen. */
DUMP total_tuples;
