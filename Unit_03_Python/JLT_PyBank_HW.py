


# Dependencies
import pandas as pd



# Data file source
data_file = 'C:/Users/julia/Documents/SMU Data Science Bootcamp/SMU-DAL-DATA-PT-08-2019-U-C/02-Homework/03-Python/Instructions/PyBank/Resources/budget_data.csv'



# Read the CSV file
data_file_pd = pd.read_csv(data_file)
data_file_pd.head()



# Find the number of unique months in the csv
unique = data_file_pd["Date"].unique()
print(f'Total Months: {len(unique)}')




# The net total amount of "Profit/Losses" over the entire period
ntsum = data_file_pd["Profit/Losses"].sum()
ntsum
print(f'Net Total Profits/Losses: ${ntsum}')




# The average of the changes in "Profit/Losses" over the entire period
average = data_file_pd["Profit/Losses"].mean()
average
print(f'Average Profits/Losses: ${average}')


# The greatest increase in profits (date and amount) over the entire period
# add a column to find the change between months
change = 0 
change = data_file_pd["Profit/Losses"].diff(periods=1)
data_file_pd["Change"] = change
data_file_pd.head()



# find the max change over the column change and filter to find its correlating month
maxchange = data_file_pd["Change"].max()
maxchange

# boolean to find when change = maxchange
monthmaxtest = (data_file_pd["Change"] == maxchange)

# pull month for when that is true
monthmax = data_file_pd[monthmaxtest].Date.values[0]
monthmax


# The greatest decrease in losses (date and amount) over the entire period
# find the min change over column change 
minchange = data_file_pd["Change"].min()
minchange


# Find out where the profit/losses column = decrease value 
date_decrease_test = (data_file_pd["Change"] == minchange)
date_decrease_test

# pull the month for that value 
monthmin = data_file_pd[date_decrease_test].Date.values[0]
monthmin



# print results 
str1 = str(f'Financial Analysis\n------------------\nTotal Months: {len(unique)}\nNet Total Profits/Losses: ${ntsum}\nAverage Profits/Losses: ${average}\nGreatest Increase in Profits: {monthmax} (${maxchange})\nGreatest Decrease in Profits: {monthmin} (${minchange})')
print(str1)


# write results to file 
file2 = open(r"C:/Users/julia/Documents/SMU Data Science Bootcamp/SMU-DAL-DATA-PT-08-2019-U-C/02-Homework/03-Python/Instructions/PyBank/export1.txt","w") 

file2.writelines(str1)

