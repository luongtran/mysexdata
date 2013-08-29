<h1>My Sex Database</h1>
<p>This App contains two modules: a REST API and an admin webpage(http://localhost:3000/doc). These two parts are incorporated in the same package.
  All is implementend using Rails 4 and Ruby 2.0 and a group of gems that are listed in Gemfile.

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
    <li><b>Premium:</b> It indicates if this user has a preimum account or not</li>
</ul>

<h4>Friendhips</h4>
<h5>Parameters:</h5>
<ul>
    <li><b>Id:</b> Row identifier</li>
    <li><b>User_id:</b> Id that identifies a user</li>
    <li><b>Friend_id:</b> Id that identifies user friend</li>
    <li><b>Accepted:</b> It shows if a user friend have accepted the invitation</li>
    <li><b>Pending:</b> It indicates if the invitation is pending to answer. If accepted is false and pending too, then the friend doesn't want to be your friend</li>
    <li><b>Secret_lover_ask:</b> It indicates if there is a request to show secret lovers to the given user</li>
    <li><b>Secret_lover_Accepted:</b> It indicates that user accepts to show his secret lovers to the given user</li>

</ul>

<h4>Lovers</h4>
<h5>Parameters:</h5>
<ul>
    <li><b>Lover_id:</b> Id that identifies a lover</li>
    <li><b>Facebook_id:</b> Id that identifies facebook user account</li>
    <li><b>Name:</b> Facebook user name</li>
    <li><b>photo_url:</b> URL to facebook profile photo</li>
    <li><b>Age:</b> Lover age</li>
    <li><b>Sex_gender:</b> User sex gender</li>
    <li><b>Job:</b> Lover job status: with job, unemployed,...</li>
    <li><b>Height:</b> Lover height</li>
</ul>

<h4>Experiences</h4>
<h5>Parameters:</h5>
<ul>
    <li><b>Experience_id:</b> Id that identifies an experience</li>
    <li><b>Date:</b> Date of the experience</li>
    <li><b>Moment:</b> Moment when the experience was done (Morning, Afternoon, Night).</li>
    <li><b>Location:</b> Where the experience was done</li>
    <li><b>Place:</b> Where the experience was done. These options are predefined, while the previous filed not.</li>
    <li><b>Detail_one:</b> If we speak about men, it will be related with first pennis option, and if we speak about women, with first breasts option</li>
    <li><b>Detail_two:</b> If we speak about men, it will be related with second pennis option, and if we speak about women, with second breasts option</li>
    <li><b>Detail_three:</b> It only can be related with women, because men don't have three pennis option.</li>
    <li><b>Hairdressing:</b> Hairdressing rate</li>
    <li><b>Kiss:</b> Kiss rate</li>
    <li><b>Oral_sex:</b> Oral sex rate</li>
    <li><b>Intercourse:</b> Intercourse rate</li>
    <li><b>Caresses:</b> Caresses rate</li>
    <li><b>Anal_sex:</b> Anal sex rate</li>
    <li><b>Post_intercourse:</b> Post-intercourse rate</li>
    <li><b>Repeat:</b> It indicates if a user can repeat this experience with the same lover</li>
    <li><b>Visibility:</b> It indicates if the user will allow geolocation for this user</li>
    <li><b>Times:</b> Number of times that this experience is done</li>
    <li><b>Personal_score:</b> Number that indicates how much the user likes this experience</li>
    <li><b>Msd_score:</b> Mark that the own app will calculate depending on the rates</li>
    <li><b>Final_score:</b> Final average of two scores</li>



</ul>

<h4>Messages</h4>
<h5>Parameters:</h5>
<ul>
    <li><b>Id:</b> Row identifier</li>
    <li><b>Receiver_id:</b> Id of the user that receives the message</li>
    <li><b>Sender_id:</b> If of the user that sends the message</li>
    <li><b>Content:</b> Content of the message</li>
</ul>

<h4>Photos</h4>
<h5>Parameters:</h5>
<ul>
    <li><b>Photo_id:</b> Id that identifies a photo</li>
    <li><b>Name:</b> Photo's name</li>
</ul>

<h4>Geosexes</h4>
<h5>Parameters:</h5>
<ul>
    <li><b>User_id:</b> Id that identifies a user</li>
    <li><b>Acces:</b> User allows or not to be geolocated</li>
    <li><b>Lat:</b> Latitude location</li>
    <li><b>Long:</b> Longitude location</li>
    <li><b>Address:</b> Reverge geocoding adrres</li>
</ul>

<h4>External_Invitations</h4>
<p>If Receiver is setted, then the rest of the parameters could not appear. This is because invitations are done separated. You can invite a friend through
email or facebook.
<h5>Parameters:</h5>
<ul>
    <li><b>Id:</b> Row identifier</li>
    <li><b>Sender_id:</b> User that sends invitation</li>
    <li><b>Receiver:</b> Email of the receiver</li>
    <li><b>Facebook_id:</b> Facebook id of the receiver</li>
    <li><b>Name:</b> Receiver's name</li>
    <li><b>Photo_url:</b> Receiver's photo url from facebook.</li>
</ul>

<h4>Admin_users, active_admin_comments and blocked users</h4>
<p>These are tables that are used to managed Admin Webpage.
<h5>Blocked_users:</h5>
<h6>Parameters:</h6>
<ul>
      <li><b>Id:</b> Row identifier</li>
      <li><b>User_Id:</b> Id that identifies a user</li>
      <li><b>Blocked_user_id:</b> Id of the user that are blocked</li>
      <li><b>Blocked:</b> It indicates if the user is blocked or not</li>
      <li><b>Desription:</b> It shows why this user is blocked or some additional information</li>
</ul>

<h2> How to run </h2>
To deploy all code we use Heroku, a cloud platform that allows to launch your application through your git repository. To run the code we will do the next:
<br>
<p>1. Install Ruby 2.0 and Rails 4.
<p>2. Install and configure PostgresSQL (if you want to work in localhost)
<p>3. Download code from repository: https://github.com/bengg/MSD-rails
<p>4. Execute "bundle exec" to install Gemfile gems.
<p>5. Execute "rake db:repopulate_production" to populate database with admin and some users.
<p>6. Execute "rails s" to start rails server
<p>7. Access to http://localhost:3000/doc to see if you can visit documentation.
<p>8. Access to http://localhost:3000/admin to see if you can access to admin webpage.
<p>9. Start sending requests to each REST resource, like http://localhost:3000/users.json to get the list of users.
<p>10. If all is ok, git push to the repository.
<p>11. Finally execute git push heroku master to deploy git code into heroku cloud server.

<p>*If you do a change in Database, you must drop it and create or create new migration files if you want to keep all data.


