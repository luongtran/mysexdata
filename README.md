<h1>My Sex Data API</h1>
------------------------

This App contains two modules: a REST API and an admin webpage(http://localhost:3000/doc). These two parts are incorporated in the same package.

REST API
--------
This API provides information about users and his friendships between other users as well as user lovers, messages, pictures and geolocation.
There are eight controllers that correspond to each resource: User, Friendship, Lover, Experience, Photo, Message, Geosexe and Session. Last controller
is used to manage user sessions during app and authenticate each request.

Authentication
------------
MSD use Basic Authentication thorugh an aphanumerical token. This token is provided by the server the first time you register in app, then,
for each request, you must send it  as a HTTP Header with the key "Authentication" and value "Token token=<token>".

Users
-----
Since User is the main focus of the app, you can list all of them, create new, delete or update.

Friendships
----------
You can create friendships between two users that are in the app or not. If you want, you can invite friends via email or via facebook. Then, when he/she
receives the corresponding email or notification, he/she can register in the app and automatically will be your MSD friend.

Lovers
------
In this app you can also add lovers, people with whom you can have a sexual experience. These lovers are identified by his facebook id and can be
users or not.

Experiences
----------
A User can have an experience with a lover, at least. In this part we will detail all information about experience. When all fields are complete, the app
will calculate an score to evaluate the experience.
