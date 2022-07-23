import pandas as pd


def calculate_demographic_data(print_data=True):
    # Read data from file
    df = pd.read_csv('adult.data.csv')

    # How many of each race are represented in this dataset? This should be a Pandas series with race names as the index labels.
    race_count = df['race'].value_counts()

    # What is the average age of men?
    male_data=df[df.sex == 'Male']
    average_age_men = round(male_data['age'].mean(),1)

    # What is the percentage of people who have a Bachelor's degree?
    total_people=df.shape[0]
    education=df['education'].value_counts()
    ed_bac=education['Bachelors']
    percentage_bachelors = round((ed_bac/total_people)*100,1)

    # What percentage of people with advanced education (`Bachelors`, `Masters`, or `Doctorate`) make more than 50K?
    # What percentage of people without advanced education make more than 50K?

    # with and without `Bachelors`, `Masters`, or `Doctorate`
    higher_education = education['Bachelors'] + education['Masters'] + education['Doctorate']
    lower_education = total_people-higher_education
    
    # with with salary >50K
    high_salary=df[df.salary == '>50K']
    education_hs=high_salary['education'].value_counts()
    higher_education_hs = education_hs['Bachelors'] + education_hs['Masters'] + education_hs['Doctorate']
    lower_education_hs =  high_salary.shape[0]-higher_education_hs

    # percentage with salary >50K
    higher_education_rich = round((higher_education_hs/higher_education)*100,1)
    lower_education_rich = round((lower_education_hs/lower_education)*100,1)

    # What is the minimum number of hours a person works per week (hours-per-week feature)?
    min_work_hours = df['hours-per-week'].min()

    # What percentage of the people who work the minimum number of hours per week have a salary of >50K?
    num_min_workers = high_salary.loc[high_salary['hours-per-week'] == 1, 'hours-per-week'].count()
    
    rich_count=df.loc[df['hours-per-week'] == 1, 'hours-per-week'].count()

    rich_percentage = int((num_min_workers/rich_count)*100)

    # What country has the highest percentage of people that earn >50K?
    
    countries=df['native-country'].value_counts()
    countries_hs=high_salary['native-country'].value_counts()
    max_percentage=0

    for i in range(countries_hs.shape[0]):
        percentage_per_country=round((countries_hs[i]/countries[countries_hs.index[i]])*100,1)
        if percentage_per_country>=max_percentage:
            max_percentage=percentage_per_country
            name_of_country=countries_hs.index[i]
            
    highest_earning_country = name_of_country
    highest_earning_country_percentage = max_percentage

    # Identify the most popular occupation for those who earn >50K in India.
    india_hs=high_salary[high_salary['native-country'] == 'India']
    india_occupation_hs=india_hs['occupation'].value_counts()
    top_IN_occupation = india_occupation_hs.index[0]

    # DO NOT MODIFY BELOW THIS LINE

    if print_data:
        print("Number of each race:\n", race_count) 
        print("Average age of men:", average_age_men)
        print(f"Percentage with Bachelors degrees: {percentage_bachelors}%")
        print(f"Percentage with higher education that earn >50K: {higher_education_rich}%")
        print(f"Percentage without higher education that earn >50K: {lower_education_rich}%")
        print(f"Min work time: {min_work_hours} hours/week")
        print(f"Percentage of rich among those who work fewest hours: {rich_percentage}%")
        print("Country with highest percentage of rich:", highest_earning_country)
        print(f"Highest percentage of rich people in country: {highest_earning_country_percentage}%")
        print("Top occupations in India:", top_IN_occupation)

    return {
        'race_count': race_count,
        'average_age_men': average_age_men,
        'percentage_bachelors': percentage_bachelors,
        'higher_education_rich': higher_education_rich,
        'lower_education_rich': lower_education_rich,
        'min_work_hours': min_work_hours,
        'rich_percentage': rich_percentage,
        'highest_earning_country': highest_earning_country,
        'highest_earning_country_percentage':
        highest_earning_country_percentage,
        'top_IN_occupation': top_IN_occupation
    }
