import requests
import pandas as pd

# Define the base URL for the API
url = 'http://universities.hipolabs.com/search'

# Function to get data from the API based on the country
def get_universities_data(country):
    # Send the GET request with the country as a filter
    response = requests.get(url, params={'country': country})
    
    # Check if the response is empty (i.e., no data)
    if response.status_code == 200:
        try:
            # Attempt to parse JSON
            data = response.json()
            
            # If data is empty
            if not data:
                print(f"No data found for country: {country}")
                return pd.DataFrame()  # Return empty dataframe if no data is found
            
            return pd.DataFrame(data)
        
        except ValueError as e:
            # Handle JSON parsing errors
            print(f"Error parsing JSON: {e}")
            print("Raw response:", response.text)  # Print raw response for debugging
            return pd.DataFrame()  # Return empty dataframe if parsing fails
    else:
        print(f"Failed to retrieve data. Status code: {response.status_code}")
        return pd.DataFrame()

# Function to filter and format the data
def filter_and_format_data(df):
    # Filter out rows where 'state-province' is missing
    df_filtered = df[df['state-province'].notna()]

    # Select and rename the relevant columns
    df_filtered = df_filtered[['name', 'web_pages', 'country', 'domains', 'state-province']]
    df_filtered.columns = ['Name', 'Web pages', 'Country', 'Domains', 'State Province']
    
    return df_filtered

# Main execution
country = 'United States'  # Example: Change country as needed
universities_df = get_universities_data(country)

# If data is found, apply filtering and formatting
if not universities_df.empty:
    filtered_data = filter_and_format_data(universities_df)
    print(filtered_data)
else:
    print("No data available for the given country.")
