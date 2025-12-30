#!/usr/bin/env python
# coding: utf-8

# In[6]:


import pandas as pd
import glob
import os

# set the folder path to where csvs are

folder_path = 'C:/Users/jmlaw/OneDrive/Documents/Data Analyst Projects/Baltimore_Web_Scraping/scraped_data'

# find all csvs in foolder

csv_files = glob.glob(os.path.join(folder_path, '*.csv'))

# read and concatenate

df_list = [pd.read_csv(file) for file in csv_files]
merged_df = pd.concat(df_list, ignore_index = True)

# drop exact duplicates
merged_df.drop_duplicates(inplace=True)

# save to new csv

merged_df.to_csv('C:/Users/jmlaw/OneDrive/Documents/Data Analyst Projects/Baltimore_Web_Scraping/scraped_data/consolidated_csv.csv', index=False)

print ('Success!')
