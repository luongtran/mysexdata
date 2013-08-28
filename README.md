<h1>My Sex Database</h1>
<p>This App contains two modules: a REST API and an admin webpage(http://localhost:3000/doc). These two parts are incorporated in the same package.

<h2>REST API</h2>
<p>This API provides information about users and his friendships between other users as well as user lovers, messages, pictures and geolocation.
There are eight controllers that correspond to each resource: User, Friendship, Lover, Experience, Photo, Message, Geosexe and Session. Last controller
is used to manage user sessions during app and authenticate each request.

<h4>Authentication</h4>
<p>MSD use Basic Authentication thorugh an aphanumerical token. This token is provided by the server the first time you register in app, then,
for each request, you must send it  as a HTTP Header with the key "Authentication" and value "Token token=<token>".

<h4>Users</h4>
<p>Since User is the main focus of the app, you can list all of them, create new, delete or update.

<h4>Friendships</h4>
<p>You can create friendships between two users that are in the app or not. If you want, you can invite friends via email or via facebook. Then, when he/she
receives the corresponding email or notification, he/she can register in the app and automatically will be your MSD friend.

<h4>Lovers</h4>
<p>In this app you can also add lovers, people with whom you can have a sexual experience. These lovers are identified by his facebook id and can be
users or not.

<h4>Experiences</h4>
<p>A User can have an experience with a lover, at least. In this part we will detail all information about experience. When all fields are complete, the app
will calculate an score to evaluate the experience.

<h4>Photos</h4>
<p>Users can upload a limited number of photos in our FTP server. To access it go to 1and1.es and there will be showed a list of all user profile
  photos in profile_picture folder.

<h2>ADMIN Webpage</h2>
<p>In this web you can manage all users. You can delete, create, update or list them. Another functionality that provides is the possibility to block
users that receive a lot of abuse messages.
