# Overview
This project presents an analysis of the data job market, with a primary focus on data analyst roles. It was developed to better understand industry trends and to navigate job opportunities more effectively. The analysis highlights the most in-demand and highest-paying skills to help identify the most valuable areas for aspiring data analysts to focus on.

The dataset used in this project is sourced from Luke Barousse’s Python course, which provides detailed information on job titles, salaries, locations, and required skills. Using a series of Python scripts, this project explores key questions such as identifying the most sought-after skills, analyzing salary trends, and examining the relationship between skill demand and compensation in the data analytics field.

# The Questions
Below are the questions I want to answer in my project:

- What are the skills most in demand for the top 3 most popular data roles?
- How are in-demand skills trending for Data Analysts?
- How well do jobs and skills pay for Data Analysts?
- What are the optimal skills for data analysts to learn? (High Demand AND High Paying

# Tools and Technologies used
For this project, I utilized a combination of programming, data analysis, and version control tools to efficiently process, analyze, and present the data:

- Python – Used as the core programming language for data analysis and automation
- Pandas – Enabled efficient data cleaning, manipulation, and transformation of datasets
- Matplotlib and Seaborn – Used to create clear and insightful data visualizations for trend analysis
- Jupyter Notebook – Facilitated exploratory data analysis and step-by-step execution of code
- Visual Studio Code (VS Code) – Provided a robust environment for writing, managing, and organizing project scripts
- Git and GitHub – Used for version control, tracking changes, and maintaining the project repository

# The Analysis

## 1. What are the most demanded skills for the top 3 most popular data roles

To find the top 5 most popular skills in the top 3 most popular roles, first I filtered the data to find the top 3 most popular data roles in the India then I wrote the query to find out the top 5 skills which one should focus on to get into these data roles and also provided a visualization of my findings.

View my notebook with the detailed steps here :
[2_skill_count.ipynb](3_project\2_skill_count.ipynb)

### Visualization data
```python
fig, ax = plt.subplots(len(job_titles),1)

for i, job_title in enumerate(job_titles):
    df_plot = df_skills_count[df_skills_count['job_title_short'] == job_title].head(5)
    df_plot.plot(kind='barh', x='job_skills', y='skill_count', ax=ax[i],title = job_title, legend=False)

plt.show()
```
### Results

![Visualization of top skills for data nerds](3_project\images\output_2.png)

### Insights

- Python has a huge importance in all of the roles and a significant majority in data science roles.
- SQL is the most important skill among all, as it is required in all these top roles more than 45% in all of these roles.
- Knowledge of cloud platforms play a significant role in Data Engineering and Data Scientist roles.
- Although mostly neglected, data shows excel plays a key role in data analyst jobs.

## 2. How are in demand skills trending for Data Analysts ?

### Visualization data

```python
from matplotlib.ticker import PercentFormatter
ax.yaxis.set_major_formatter(PercentFormatter())

colors = sns.color_palette('tab10', n_colors=5)
texts = []
for i, col in enumerate(df_plot.columns):
    texts.append(ax.text(11.2, df_plot.iloc[-1, i], col, fontsize=9, color=colors[i]))

# Automatically separates overlapping labels
adjust_text(texts, only_move={'points': 'y', 'texts': 'y'})

plt.tight_layout()
plt.show()
```

### Results

![Trending top skills for Data Analysts in India](3_project\images\output_3.png)

*Bar graph visualizing the trends for the top skills for Data Analysts in India in the year 2023*

### Insights

- Demands for SQL is mostly steady and the highest and also the trend shows it to be increasing

- The demand for python and excel have increased steadily and have been almost similar throughout the year

- There has been a slight dip for the interest in tableau although it seems to be increasing significantly towards the end but power bi seems to have caught up with tableau.

## 3. How well do jobs and skills pay for Data Analysis

### Highest paid and most in-demand skills for data
### Visualize data
 ```python
 sns.boxplot(data=df_IND_top6, x='salary_year_avg', y='job_title_short', order=job_order)
plt.title('Salary Distribution in India for Top 6 Job Titles')
plt.xlabel('Yearly Salary ($USD)')
plt.ylabel('')
ax = plt.gca()
```
## Results

![ Salary distributions of data jobs in India](3_project\images\output_4.png) 

## Insights
- Median yearly salary of Data Engineer are greater than Senior Data Engineer this needs further analysis to find out the reason for this trend.

- Data analysts in India tend to earn a stable median yearly salary.

- No senior data analyst and data scientist jobs are present in the list.

## 3. How well do jobs and skills pay for Data Analysis
### Highest paid and most in demand skills for Data Analysis
### Visualize data
 ```python
 #Top 10 highest paying skills for Data Analysts

sns.barplot(data=df_DA_top_pay, x='median', y=df_DA_top_pay.index, ax=ax[0], hue= 'median', palette='dark:b_r')
ax[0].legend_.remove()

#Top 10 most in demand skills for Data Analysts

sns.barplot(data=df_DA_skills, x='median', y=df_DA_skills.index, ax=ax[1], hue= 'median', palette='light:b')
ax[1].legend_.remove()

```

!['Highest paid and most in demand skills for Data Analysts in India'](3_project\images\output_5.png)

## Insights
- The analysis shows us that skills involving big data pays more salary along with knowing SQL skills and python skills 

- Without any surprise the most in demand skills are SQL, excel, python, tableau, r and power bi 

- So in conclusion one can get into Data Analysis knowing the basic tools and can further increase their salary by learning big data tools

## 4. What are the most optimal skills to learn for Data Analysis ?
### Visualize data
 ```python
from adjustText import adjust_text

#df_DA_skills_high_demand.plot(kind = 'scatter', x = 'skill_percent', y = 'median_salary')
sns.scatterplot(
    data = df_plot,
    x='skill_percent',
    y='median_salary',
    hue='technology'
)

``` 
!['Most optimal skills for data analysts in India'](3_project\images\output_6.png)

## Insights
- Sql is the most in demand skill for data analysts along with excel and python

- Knowledge of analyst tools can help in increasing the median yearly salary  

- So we can infer that knowledge of programming languages like python and sql along with the knowledge of analyst tools like power bi, excel and tableau can not only land a good job, but also increase ones existing salary

# What I learned ?

Through this project, I gained practical experience in analyzing real-world job market data and strengthened my overall data analysis workflow. Key learnings include:

- Developed the ability to clean, transform, and analyze large datasets using Pandas
- Improved data visualization skills by creating meaningful insights using Matplotlib and Seaborn
- Gained a deeper understanding of the data job market, including in-demand skills and salary trends
- Learned how to translate raw data into actionable insights that can guide career decisions
- Strengthened problem-solving skills by breaking down complex questions into structured analysis steps
- Improved proficiency in using Jupyter Notebook and VS Code for efficient project development
- Gained hands-on experience with Git and GitHub for version control and project management

# Challenges I faced
- The most challenging aspect of the project was finding complete data, even after the visualization there are some places where I feel like I need more data for further analysis so that I can provide better conclusion
- Data cleaning was also a challenging aspect but I quiet enjoyed the process of turning the messy data into a useful information for my analysis

# Conclusion
This project provides a powerful insight for an upcoming data analyst in India who's trying to land a job, with the help of this he/she can know the actual skills required to land a job initially and what skills must be further learnt in order to increase the salary


