
<h1>GameBook 🕹️ </h1>
----------------------------------

<h2>About:</h2>
This is a platform for gamers to track all their game collections linked with their owned platforms, and to share their collections with their friends. It's a game and social platform between friends, to check what games our friends are playing right now, and to organise to play together. 

The key is cross platforms but keep within small communities, not mean to show your data to others which is not your friends.

There is a chatroom feature to message with friends or leave messages to them, in order to discuss about the game or orgnise a game party together.

This platform is based on the [RAWG API](https://rawg.io/apidocs), all the game information are from their database, only user concerned data is stocked under this platform.

challenge: different than the normal rails app, as the essential datas are from an API, the app is built mostly on ajax controllers to communicate with the back.

<h2>New feature: </h2> 
We added a "Personally game recommedation systhem" coded in Python during my data science bootcamp with colleagues, which used 3 machine learning models: 
  <li>Content base model to find games the most similar with one given game</li>
  <li>Knn Model to find most similar user with given game collection</li>
  <li>unsupervised learning with Collaborative Filtering Model </li>
  <br>

Built on FastAPI, and deployment with Google cloud platform to host the API.

<strong>The details of this projet is in this Repo <a href="https://github.com/Agnes-Lain/game_one">[Game one]</strong>

<h2>Gallery</h2>

![image](https://github.com/Agnes-Lain/Gamebook/assets/60975663/b093e1b1-9072-4209-b4a6-3ac5f874c403)
![image](https://github.com/Agnes-Lain/Gamebook/assets/60975663/64d9e67c-34f7-427d-80f4-4d0b3d0311b4)
![image](https://github.com/Agnes-Lain/Gamebook/assets/60975663/bcbac129-adc0-4b4e-b825-81eca70ecd3c)


Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.
