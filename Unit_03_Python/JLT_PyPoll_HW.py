


# Dependencies
import pandas as pd



# Data file source
data_file = 'C:/Users/julia/Documents/SMU Data Science Bootcamp/SMU-DAL-DATA-PT-08-2019-U-C/02-Homework/03-Python/Instructions/PyPoll/Resources/election_data.csv'


# Read the CSV file
data_file_pd = pd.read_csv(data_file)
data_file_pd.head()


# The total number of votes cast
totalcount = data_file_pd["Voter ID"].count()
totalcount



# A complete list of candidates who received votes
data_file_pd["Candidate"].unique()



# add a column to count number of votes
count = 1
data_file_pd["Voter Count"] = count
data_file_pd.head()



# pull in just the candidate and voter count columns and groupby candidate
# The total number of votes each candidate won
grouped_df = data_file_pd[["Candidate","Voter Count"]].groupby(["Candidate"])
df_comparison = grouped_df.sum()
print(df_comparison)



# The percentage of votes each candidate won
percentwon = df_comparison["Voter Count"]/totalcount
df_comparison["Percent Won"] = percentwon 
percent_format = {'Percent Won': '{:.2%}'}
df_comparison.style.format(percent_format)



# The winner of the election based on popular vote.
winner = df_comparison["Voter Count"].max()
winnername = (df_comparison["Voter Count"] == winner)
name = df_comparison[winnername]
name.index[0]




# Print Results 
str1 = str(f'Election Results\n------------------\nTotal Votes: {totalcount}\n------------------------\n{df_comparison.iloc[:,:]}\n---------------------\nWinner: {name.index[0]}\n---------------------')
print(str1)



file2 = open(r"C:/Users/julia/Documents/SMU Data Science Bootcamp/SMU-DAL-DATA-PT-08-2019-U-C/02-Homework/03-Python/Instructions/PyPoll/export2.txt","w") 
file2.writelines(str1)






