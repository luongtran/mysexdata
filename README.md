<h1>My Sex Database</h1>
<p>This App contains two modules: a REST API and an admin webpage(http://localhost:3000/doc). These two parts are incorporated in the same package.

<h2>REST API</h2>
<p>This API provides information about users and his friendships between other users as well as user lovers, messages, pictures and geolocation.
There are eight controllers that correspond to each resource: User, Friendship, Lover, Experience, Photo, Message, Geosexe and Session. Last controller
is used to manage user sessions during app and authenticate each request.
<p> Also, we created some models that corresponds to database table and some views for each model to show the json response content .

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

<h4>Messages</h4>
<p>Users can communicate between them sending messages. Theses messages are 140 characters length. Every X number, theses messages have to
  be cleaned from database in order not to increase database data.

<h4>Geosex</h4>
<p> Yo get nearest users of you, we use geolocation gem that provides nearest users giving a distance. To use geosex, first user have to send his first
  location when enables geolocation and then update it.


<h2>ADMIN Webpage</h2>
<p>In this web you can manage all users. You can delete, create, update or list them. Another functionality that provides is the possibility to block
users that receive a lot of abuse messages.
<p>This webpage is created using activeadmin gem that provides a full integration with our ruby models.

<h2>DATABASE</h2>

<h4>Users</h4>
<h5>Parameters:</h5>
<ul>
    <li><b>User_id:</b> Id that identifies a user</li>
    <li><b>Name:</b> Facebook user name</li>
    <li><b>Email:</b> Email that user uses to log in in Facebook</li>
    <li><b>Facebook_id:</b> Id that identifies facebook user account</li>
    <li><b>Remember_token:</b> Personal alphanumerical string that allows user to send his requests</li>
    <li><b>Password_digest</b> Encoded user password</li>
    <li><b>Status:</b> Relationship status (Allow, Not allow with couple, Desperate,...)</li>
    <li><b>Facebook_photo:</b> URL to facebook profile photo</li>
    <li><b>Profile_photo:</b> Id of the photo that user have set </li>
    <li><b>Photo_num:</b> Number of photos that this user has.</li>
    <li><b>Lovers_num</b> Number of lovers that this user has.</li>
    <li><b>Job:</b> User job status: with job, unemployed,...</li>
    <li><b>Age:</b> User age</li>
    <li><b>Birthday:</b> User birthday</li>
    <li><b>Startday:</b> Date of the first relationship</li>
    <li><b>Eye_color:</b> User eye color</li>
    <li><b>Hair_color:</b> User hair color</li>
    <li><b>Height:</b> User height</li>
    <li><b>Hairdressing:</b> User hairdressing</li>
    <li><b>Sex_interest:</b> User interest</li>
    <li><b>Sex_gender:</b> User sex gender</li>
    <li><b>Preferences:</b> Array of sorting numbers that indicates your preferences</li>
    <li><b>Admin:</b> User admin permissions</li>
    <li><b>Premium:</b> It indicates if this user has a preimum account</li>
</ul>
