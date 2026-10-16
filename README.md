Hi Lacrosse Analysts!

This project actually began with another, where I looked at significant factors in team success
for NCAA Men's Lacrosse, finding faceoffs were one of the only factors with a significant positive 
correlation. I found that interesting enough and was motivated to do a project like this. 

Here you will find two CSVs, one of team data and one of faceoff specialist data. 
Both were manually scraped from NCAA's official website, and there are some flaws with the dataset. 
Not all teams have a faceoff specialist recognized in the data (e.g. Siena) while some have multiple
(e.g. Michigan). What I believe to be the case is that there is some sort of minimum # of faceoff 
attempts needed to qualify for the database, so take that into account. My R file is my model, including
the double regression I used to correlate faceoff percentage with extra goals added (xGa) and then xGa 
with wins. 
