import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import linregress

def draw_plot():
    # Read data from file
    df = pd.read_csv('epa-sea-level.csv')

    # Create scatter plot
    fig=plt.subplot()
    x=df["Year"]
    y=df["CSIRO Adjusted Sea Level"]
    plt.scatter(x, y)


    # Create first line of best fit
    result = linregress(x,y)
    # y_hat=theta0 + theta1*x
    x_pred=pd.Series([i for i in range (1880,2051)])
  
    y_pred=result.intercept + result.slope*x_pred
    
    #fig=plt.figure()
    #plt.scatter(x=df["Year"], y=df["CSIRO Adjusted Sea Level"], alpha=0.6, color='blue')
    plt.plot(x_pred,y_pred, 'r')


    # Create second line of best fit
    
    new_df=df.loc[df['Year'] >= 2000]
    x_new=new_df["Year"]
    y_new=new_df["CSIRO Adjusted Sea Level"]
    new_result = linregress(x_new,y_new)

    x_pred_new=pd.Series([i for i in range (2000,2051)])
  
    y_pred_new=new_result.intercept + new_result.slope*x_pred_new

    #fig=plt.figure()
    #plt.scatter(x=new_df["Year"], y=new_df["CSIRO Adjusted Sea Level"], alpha=0.6, color='blue')
    plt.plot(x_pred_new, y_pred_new, color='green')


    # Add labels and title
    plt.xlabel("Year")
    plt.ylabel("Sea Level (inches)")
    plt.title("Rise in Sea Level")

    
    # Save plot and return data for testing (DO NOT MODIFY)
    plt.savefig('sea_level_plot.png')
    return plt.gca()