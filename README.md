Tint Coding Challenge
============

Hashtag Battle

Build a simple webapp to display a Hashtag Battle in a technology stack of your choice. A Hashtag Battle takes two or more twitter hashtags as input and displays a counter for each hashtag. Essentially, this product can be used by brands as a voting mechanism.

Example input: A brand chooses #brand1 and #brand2 as the hashtags they want to battle.

Example output: A page that displays how many people on Twitter have tweeted with #brand1 and also a separate counter for the number of people who have tweeted with #brand2.

Constraints: Counters will start when a brand starts the Hashtag Battle, the app is not responsible for pulling in hashtags from the beginning of time.

Hosting
============

```
http://panu-hashtag-battle.herokuapp.com/
```

Warning: This application doesn't support multiple request. Please close the current browser if you don't want to use it anymore. Twitter streaming API have rate limits. Excessive connection attempts will result in an automatic ban of the IP. To be able to support multiple request, we have to use multithreading and also have cronjob to check if Twitter rate limit exceeded.

Heroku is a cloud application platform. It easy and painless to build and run cloud apps.
Package: 1 Web Dyno

Add-ons
- Heroku Postgres - Reliable and powerful database-as-a-service based on PostgresQL. We used postgres as our main database to store battle data.
- Logentries - Intelligent Log Management, providing built in Heroku-specific alerting. We used this add-on to monitor our rails log and it will send email if there is something wrong.
- Redis To Go - #1 Redis Provider with over 42,000 Redis instances. We used Redis Pub/Sub to streaming data with Rails.

Technology stack
============

- Ruby on Rails 4.1.5
- Rails 4 Live Streaming
- Twitter Streaming API
- Postgres Database
- Redis Pub/Sub
- Heroku
- Twitter Bootstrap 3
- Flat UI
- JQuery

User Stories
============

1. As a user, they can put name of the battle and hashtags to see no. of tweet for each hashtag.
2. As a user, they're able to add hashtag as much as they want but at least one.
3. As a user, they can remove any hashtag they want before the battle.
4. As a user, they're able to see no.of tweets for each hashtag input

Wireframe
============
1. Index page - https://www.dropbox.com/s/3wjjvbbmpihk4xd/index-page.png?dl=0
2. Result page - https://www.dropbox.com/s/1izezg210matvwo/result-page.png?dl=0

Fully Responsive web design
============

This site work on all enabled devices.

1. Smartphone
2. Tablet
3. Netbook
4. Desktop/ Monitor

Rspec
============

```
rspec .
```

Run rspec at the project directory to check the result

Test case cover 2 parts.
1. Battle model
2. Twitter Streaming API - it covers case sensitive cases and not cover
   the one without hashtag


Extra question
============

```
If we were to build analytics for this feature, what analytics would potentially be useful for customers that we could build with the data we have?
```

1. No. of hashtag base on location for each brand - Customer might would like to see where people interested in their product, so they can create the location-based campaigns to reach out their brand lovers.
2. No. of hashtag base on time analysis - For example, if you are Munchery or Spoonrocket, you might would like to know what meal people ordered your food and how they like it. They might expect lunch order but some user might order lunch and save it for dinner and food is still in a good condition.
3. Top user who got the highest no. of tweet for your brand - User engagement is very important. You might reward them bring to be your brand ambassador.

Also, in addition to this webapp give us your input on
============

```
1) How do you want to integrate this with our existing product from a product and business standpoint (not a technical standpoint)?
```

Tint is realtime social media aggregator. For business standpoint, I think we can build "scores" system like Klout. With this score, we can tell how customer love our product base on no. of tweet and tweet context. We can also turn social media aggreator into CRM platform that provide relation management, sales promotion analysis (automate tracking of a client’s account history for repeated sales or future sales), Opportunity management (help company to manage unpredictable growth and demand and implement a good forecasting model to integrate sales history with sales projections).


```
2) What type of analytics can you provide ?
```

1. Descriptive Analytics - How many different segments of brand lover are we dealing with? Where are they and what do they look like? How do high value customer differ from other? We can also provide the competitor analysis base on no. of tweet, location, and demographic.

2. Predictive Analytics - For example, who will respond to this campaign if we have this campagin in the future? We need carefully structured statistical models, which will return “scores” that define likelihood of customers behaving a certain way in the future. Scores will be calculated from no. of tweet and what people say about tweet (0 = unsatisfied, 10 = satisfied ) which we can tell from user feeling e.g., happy, like, love, and suck.


```
3) Briefly explain the architecture.
```

Rails 4 can stream data to the browser with ActionController::Live. It enables keeping a connection open to our server. When we fetch data from Twitter Stearming API, we use Redis to notify pub-sub channel. The Streaming request handler subscribes to this channel and forwards events to the client. On client side, we created Event Listener to pull data from our server. Please see Technology Stack section above.
