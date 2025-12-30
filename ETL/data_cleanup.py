#!/usr/bin/env python
# coding: utf-8

# In[1]:


# import libraries
# pandas for data manipulation and re for regular expressions matching text patterns
import pandas as pd
import re

# load our CSV
df = pd.read_csv("C:/Users/jmlaw/OneDrive/Documents/Data Analyst Projects/Baltimore_Web_Scraping/scraped_data/consolidated_csv.csv")

# create a state abbreviation library to recall for state function
us_state_abbrev = {
    'Alabama': 'AL', 'Alaska': 'AK', 'Arizona': 'AZ', 'Arkansas': 'AR',
    'California': 'CA', 'Colorado': 'CO', 'Connecticut': 'CT', 'Delaware': 'DE',
    'Florida': 'FL', 'Georgia': 'GA', 'Hawaii': 'HI', 'Idaho': 'ID',
    'Illinois': 'IL', 'Indiana': 'IN', 'Iowa': 'IA', 'Kansas': 'KS',
    'Kentucky': 'KY', 'Louisiana': 'LA', 'Maine': 'ME', 'Maryland': 'MD',
    'Massachusetts': 'MA', 'Michigan': 'MI', 'Minnesota': 'MN', 'Mississippi': 'MS',
    'Missouri': 'MO', 'Montana': 'MT', 'Nebraska': 'NE', 'Nevada': 'NV',
    'New Hampshire': 'NH', 'New Jersey': 'NJ', 'New Mexico': 'NM', 'New York': 'NY',
    'North Carolina': 'NC', 'North Dakota': 'ND', 'Ohio': 'OH', 'Oklahoma': 'OK',
    'Oregon': 'OR', 'Pennsylvania': 'PA', 'Rhode Island': 'RI', 'South Carolina': 'SC',
    'South Dakota': 'SD', 'Tennessee': 'TN', 'Texas': 'TX', 'Utah': 'UT',
    'Vermont': 'VT', 'Virginia': 'VA', 'Washington': 'WA', 'West Virginia': 'WV',
    'Wisconsin': 'WI', 'Wyoming': 'WY'
}

# normalize and clean up phone records
def clean_phone(val):
    if pd.isnull(val): return None # ignore null values
    digits = re.sub(r'\D', '', str(val))
    return f"({digits[:3]}) {digits[3:6]}-{digits[6:]}" if len(digits) == 10 else digits

# normalize and clean up text fields
def clean_text(val):
    if pd.isnull(val): return None
    return str(val).strip().replace(",", "").title() # clean up unnecessarry commas, spaces, capital letters

# standardize state and return as state abbreviations
def standardize_state(val):
    if pd.isnull(val): return None # ignores null values
    val = str(val).strip().title().replace(",", "")
    return us_state_abbrev.get(val, val.upper()) # recall state abbreviation library

# Master function
def clean_property_data(df):
    # date field normalization
    for date_col in ['license_expiration_date', 'scrape_date']:
        if date_col in df.columns:
            df[date_col] = pd.to_datetime(df[date_col], errors='coerce') # coerce to ignore null values

    # clean up phone numbers
    phone_cols = [col for col in df.columns if 'telephone' in col.lower()]
    for col in phone_cols:
        df[col] = df[col].apply(clean_phone)

    # standardize text
    text_cols = [col for col in df.columns if 'name' in col.lower() or 'city' in col.lower() or 'state' in col.lower()]
    for col in text_cols:
        df[col] = df[col].apply(clean_text)

    # Standardize state abbreviations
    state_cols = [col for col in df.columns if 'state' in col.lower()]
    for col in state_cols:
        df[col] = df[col].apply(standardize_state)

    return df

# Clean the data
cleaned_df = clean_property_data(df)

# Save to CSV in the same folder
cleaned_df.to_csv("C:/Users/jmlaw/OneDrive/Documents/Data Analyst Projects/Baltimore_Web_Scraping/scraped_data/cleaned_consolidated_csv.csv", index=False)

print ('Success!')

