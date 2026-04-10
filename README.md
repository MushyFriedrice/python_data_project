# The Analysis

## What are the most demanded skills for the top 3 most popular data roles

To find the top 5 most popular skills in the top 3 most popular roles, first I filtered the data to find the top 3 most popular data roles in the USA then I wrote the query to find out the top 5 skills which one should focus on to get into these data roles and also provided a visualization of my findings.

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

![Visualization of top skills for data nerds](3_project\images\skill_demand_all_data_roles.png)