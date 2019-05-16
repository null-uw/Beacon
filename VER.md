# Beacon

## Mission Statement

Stop wasting time. Make a connection.

## Problem

As students, we are often faced with empty time between classes. The process of coordinating, planning, and communicating with friends to fill these empty time slots is an organizationally annoying process for students. This process usually involves a myriad of online communication efforts like social media, instant messages, or even location sharing platforms.

## Solution

Our solution is to create a cross-mobile application that allows for on-demand location sharing to help students find friends and make better use of gaps in their schedules.

The application will have a default “off-state” meaning users will turn on their location sharing only when they want to be found.

Our project aims to implement a new type of on-demand location sharing to help connect students and find friends to make better use of gaps in their schedules.

## Team

- Leader: Ben
- Manager: Matthew
- Marketing: Ben / Charlye
- Project Management: Matthew
- Design: Joseph
- Engineering: Ben
- Support: Charlye

## Priorities

1. **Correctness** - Our application should be functional and achieve the requirements placed by the team and spec.
2. **Usefulness** - A user will only use Beacon if it is useful in their social lives.
3. **Usability** - The features should be usable in all aspects of the user’s experience.
4. **User efficiency** - Should be quick and simple when using app.
5. **Portability** - Our application should work on both Android and iOS.
6. **Privacy** - Our application is accessing user locations and should be stored securely.
7. **Security** - Our application contains user data and profiles and should be secure when managing user data.
8. **Learnability** - Our application should easily be able to set up a beacon and find other beacons.
9. **Consistency** - App will follow a design language and common design conventions
10. **Reliability** - The app and backend system should be up and usable, and not crash.
11. **Accessibility** - Any user should be able to perform the app’s functions.
12. **Robustness** - The app should not crash from unexpected errors. If the system cannot do a task, it should present the user with an error.
13. **Verifiability** - Our application will contain functional components that should be verifiable in accomplishing their functions accurately and repeatedly.
14. **Performance** - We just want our application to work.
15. **Interoperability** - The app will only work on Android and iOS devices
16. **Reusability** - Our goal is to build an app with a specific purpose, but users should be able to use it how they wish.
17. **Maintainability** - We don’t plan on revisiting this application.


## Verification Plan

### Landing Screen: Sign In

| Requirement |Verification|
|----------|----------|
| On launch, the application must show the ‘Sign in’ screen within two seconds if there is not an existing authenticated session. | We will manually verify if the sign in screen successfully loads up, within two seconds, when the app is launched without an existing authenticated session.|
| If there is an existing authenticated session, the ‘Sign in’ screen must not be shown, and instead, the ‘User Home’ screen will be shown within two seconds.  |  We will manually verify if ‘User Home’ screen loads when there is an existing authenticated session. This check should stay consistent even when the application is closed and reopened.|
| The application must accept user text input into the Email field. | We will manually verify that the email field accepts user text such as letters, numbers, and special characters. |
| Email field must have a placeholder that says “Email.” | We will manually verify to see that the placeholder says “Email” if there are no values in the field. |
| The application must accept user text input into the Password field. | We will manually verify that the password field accepts user text such as letters, numbers, and special characters. |
| Password field must have a placeholder that says “Password.” | We will manually verify to see that the placeholder says “Password” if there are no values in the field. |
| The application must hide user text input into the Password field, by hiding the characters with asterisks. | We will manually verify to see that the characters are being hidden when there are values within only the Password field. |
| The application must trigger a call to the authentication service when the user presses the ‘Sign In’ button and check if the inputted credentials match a registered user. | We will manually verify that when the password and email fields have proper inputted credentials, the ‘User Home’ screen will load up after clicking the ‘Sign In’ button. The credentials will also be manually checked in the back-end that the credentials actually do match a specific user. |
| The application must display any errors in red above the ‘Sign In’ button that are returned from the authentication service after a failed authentication service call. | <ul> <li>We will manually verify for invalid combination, invalid email, and invalid password when a user presses ‘Sign In.’ 2. <li> A red error will display ‘invalid combination’ if both email and password fields are empty. Also, if the credentials do not match a specified user’s credentials. </li><li>A red error will display ‘invalid email’ if an improper formatted email or no input was entered into the email field.</li><li>A red error will display ‘invalid password’ if a user tried to sign in with no value for the password field.</li></ul> |
| After a successful authentication service call, the application must redirect to the ‘User Home’ Screen within two seconds. | We will manually verify that the ‘User Home’ Screen loads within two seconds after signing in with proper credentials. |
| The application must change to the ‘Sign Up’ screen within two seconds, if the user clicks the ‘Sign Up’ link. | We will manually verify if the signup screen successfully loads up, within two seconds, after the ‘Sign Up’ link is clicked. |


### Landing Screen: Sign Up

| Requirement | Verification |
|----------|----------|
| The application must accept user text input into the Name field. | We will manually verify by inputting text, expecting no error and inputting non-text,  expecting an error|
| Name field must have a placeholder that says “Name.” |We will manually check to see that the placeholder says “Name” if there are no values in the field.|
| The application must accept user text input into the Email field. | We will manually verify by inputting text, expecting no error and inputting non-text, expecting an error |
| Email field must have a placeholder that says “Email.” | We will manually check to see that the placeholder says “Email” if there are no values in the field. |
| The authentication service will check if the inputted email is a valid email and will only register with a valid email or if the email has not been used already. | We will manually verify to see if ‘invalid email’ error will pop up if a poorly formatted email is inputted or if an email that is already in use is inputted. We will manually check in the back-end to verify that the email is actually already registered. |
| The application must accept user text input into the Password field. | We will manually verify by inputting text, expecting no error and inputting non-text, expecting an error |
| Password field must have a placeholder that says “Password.” | We will manually check to see that the placeholder says “Password” if there are no values in the field. |
| The application must hide user text input into the Password field, by hiding the characters with asterisks. | We will manually verify if the characters being typed are displayed as asterisks instead |
| The application must only accept passwords that are at least eight characters long, contains at least one number, and at least one uppercase and lowercase letter. | We will manually verify that only passwords that match the requirements will be passed. If the password doesn’t fulfill any one of the requirements, then an ‘invalid password’ error will be displayed. |
| The application must explain password requirements to the user below the password field. | We will manually check to see that the requirements for the creating a password is clearly displayed below the password field. |
| The application must not register the user if one of the fields are empty or contain invalid input, as mentioned above. | We will manually verify to see that an error is displayed when attempting to submit an empty or invalid input |
|The application must trigger a call to the authentication service using the credentials entered by the user in the ‘Name’, ‘Email’, and ‘Password’ fields when the user presses the ‘Sign Up’ button. If successful, the credentials will be added to the database.| We will manually check in the authentication service that a new uid was created that contains the inputted ‘Name,’ ‘Email,’ and hashed ‘Password’ field. The new user should be created after pressing the ‘Sign Up’ button with properly formatted inputs for the fields. |
|The application must display errors in red above the ‘Sign Up’ button regarding credentials that are returned from the authentication service after a failed authentication service call.| We will manually verify that the user is presented with informative errors when entering an invalid email and/or password. |
| After a successful authentication service call, the application must redirect to the ‘User Home’ Screen within two seconds.| We will manually verify that the application redirects to the home screen within two seconds of tapping “Sign in” with valid credentials.|
| The application must change to the ‘Sign in’ screen within one second after the user clicks the ‘Sign In’ link. | We will manually verify that the application routes to the sign-in screen within one second of tapping “Sign in”|



### User Home Screen: Map Requirements

| Requirement|Verification|
|----------|----------|
| The software must display the current user on the map with the accuracy of the user device’s GPS. |  We will manually verify the location shown on each device in comparison to their location shown on Google Maps. Verification of database updates will also be checked as a device is moved from one location to another. |
| The software must display the current user’s ‘friends’ with the accuracy of the user’s friend’s device’s GPS. | We will manually verify that all of the user’s friends as defined on the database are shown on the user’s device. |
| When a user’s friend’s beacon is on, they will be considered in the ‘active’ state and the software must make their marker displayed on the map and list them as ‘active’ in the user list. | We will manually verify that the user’s who are shown in an active state have database entries as shown below. <br><br> User’s location node should appear as __Figure 1__
| When a user’s friend beacon is off, they will be considered in the ‘inactive’ state and the software must not display their marker on the user’s map and list them as ‘inactive’ in the user’s friend list.| We will manually verify that the user’s who are shown in an inactive state have database entries as shown below. <br><br> User’s location node should appear as __Figure 2__
| The application must display 'active' users on the map with a circle marker of a randomly generated color and the user’s first initial in the middle.  |We will manually verify that all of the user’s friends who have active states in the database are displayed on the map.
| The application must display users who have their beacon ‘ON’ above users who have their beacon ‘OFF’ in the user list.| We will manually verify that the list is sorted to have active users on top of inactive users.|
| The application must capture the current user’s location and share to all of the user’s followers if they toggle the beacon form ‘inactive’ to ‘active’| We will manually verify that the user’s location node is updated when the Beacon toggle is turned on. <br> <br> User’s location node should appear as __Figure 1__
|The application must not display the current user’s location to any of their followers if the current user toggles their beacon from ‘active’ to ‘inactive’. | We will manually verify that the user’s location node is updated to be without their location when the Beacon toggle is turned on. <br> <br> User’s location node should appear as __Figure 2__
|The user’s current location must not be sent to any data storage solutions when the Beacon toggle is off.| We will manually verify that the user’s location node is removed from the user’s locations in the database. While the user’s “ and “email” will remain, the user’s “location” should not be included in the database’s locations as shown in __Figure 2__
| The user’s current location must be shared with the user’s friends when the Beacon toggle is on. When the Home screen is loaded, the application must call the database and load all of the current user ‘active’ friend’s locations.| We will manually verify that all of the Firebase streams are established when the User home screen is initialized. This is verifiable by checking for location updates when data on the database is changed. This can be done via the Firebase console on a test account.
|The software must redirect the screen to the ‘Friend Preference’ screen if the ‘Friend Preference’ icon is clicked. | We will manually test that when the icon is clicked, it will route to the “Friend Preference” screen|

##### Figure 1

~~~~
locations: {
     uid: {
          name: String,
          email: String,
          location: {
               lat: double,
               lng: double
          }
     }
}
~~~~

##### Figure 2
~~~~
locations: {
     uid: {
          name: String,
          email: String,
      }
}
~~~~


### User Home Screen: Signout Behavior Requirements

| Requirement|Verification|
|----------|----------|
| When the user clicks the top left ‘Sign out’ icon, the application must display a modal within one second with two options (‘Sign out’ or ‘Cancel’) to confirm the user’s action. |  We will manually test this by clicking on the sign out icon and timing that the modal displays in 1 second. <br> <br> We will manually verify that there the two options displayed are ‘Sign out’ and ‘Cancel’
| When the user clicks the ‘Sign out’ button on the modal, the application must un-authenticate the current user and redirect to the ‘Landing’ Screen within two seconds. |    We will manually test this by clicking the ‘Sign out’ option on the signout modal. We will verify that a successful sign out has been accomplished by following these criteria: <br> <br> 1. User’s location node in Firebase has been updated to have NO location. Location node should appear as __Figure 2__  <br> <br> 2. In the network timeline of the device, a Firebase un-authentication call has been made <br> <br> 3. The User is redirected to the Signup Screen’ within 2 seconds of clicking ‘Sign out’. <br> <br> 4. Upon exiting and re-entering the application, no user auth session is present and the ‘Sign up’ page is displayed.|
| When the user clicks the ‘Cancel’ button on the popup, the application must close the modal and re-display the ‘User Home’ screen. | We will manually verify that when a user clicks on the “cancel” button on the popup, it closes the modal and re-displays the Home Screen. |

##### Figure 3
~~~~
locations: {
     uid: {
          name: String,
          email: String,
          location: {
               lat: double,
               lng: double
          }
     }
}
~~~~



### Friend Preferences

| Requirement|Verification|
|----------|----------|
| User must be able to navigate to this screen from the ‘User Home’ screen, after pressing the request button at the top right within two seconds.|We will manually verify if the home screen transitions to the friend preference screen within 2 seconds.
| The application must display all friend requests sent from other users on the application. |We will manually verify that the application renders the friend request component. We will check if the component title is rendered, if there is no request it will display a “no request message” otherwise it will display the all request in a list|
|Each request must display the email and name of the user that is requesting to be friends.| We will manually verify that the email and name of a user for each request is rendered|
| Each request must display buttons to enable the user to accept or deny a request.| We will manually verify that the two buttons are rendered and the buttons perform as expected|
| The request must disappear when the user denies a friend request. |    We will manually verify that the specific request has been removed from the user’s request object and the UI component |
| The request must disappear when the user accepts a friend request. The newly accepted friend must be added to the current list of friends the user has, which will be visually shown in the friend's list on the ‘User Home’ screen. |We will manually verify that the specific request has been removed from the user’s request object and the Request UI component. We will also manually verify that both user’s user object has been appended to each other's friends object and on the Home Screen Map Component|
| The application displays a search bar to enable the user to search for another user by email.| We will manually verify that there is a search bar that exists and accepts a user’s email input. |
|The search bar placeholder must say “search by email.” | We will manually verify that the placeholder says “search by email” |
| The search bar must accept user text input. | We will manually verify that the search bar accepts a user’s email input and shows an error message “invalid email” if the email is invalid. |
|If the query has matching emails, the application must display the possible emails that match the query, alongside the corresponding display name.|    We will manually verify that when a user enters an existing email in the search bar, it shows the email and display name of the found user. |
| A button must also be displayed next to the email and name that says “Add friend” to enable the user to send an invite to the user they searched.| We will manually verify that when an existing user is found, there is a button alongside the email and display name that says “Add friend”. We will also verify that when the button is pressed, the current user gets added to the friend’s requests in the database.|
| The application must display a toast confirmation that the invite was sent, within one second.|  We will manually verify that when the user taps the “Add friend” button, a toast confirmation will show within one second. |
| The user must be able to return to the home screen within one second, using a back button at the top left corner.| We will manually verify that when the user taps the back button, the application returns back to the home screen within 1 second.|
