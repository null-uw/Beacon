# Beacon

## Specifying Process

### How will you communicate with teammates you depend on? Describe specific tools or contexts.

| __Tool__                                                       |                                               __Use-case__           |
| :------------------------------------------------------------: | :------------------------------------------------------------------: | 
| Facebook Messenger (IM & Video) | General communication, assignment updates, 911 emergencies|  
| In-person Meetings | Team meetings, general updates, bug bashes, individual meetings, retrospectives, planning |
| Github Issues | Unexpected issues that arise that are not documented in the architecture document. |

### What coordination and planning practices will you follow? Identify daily scrums, sprint planning meetings, ad hoc meetings, or other ways of coordinating work.

Each day before work, we will have stand-up meetings to discuss work that each member has completed as well as what they are working on.

Project Manager will manage, prioritize, and delegate work to developers via tasks on Github Projects. The PM will begin meetings with initial check-in's on the developer’s progress on tasks and clean up the board if necessary. 

All hands ad-hoc meetings may be called by any team member if there is a necessary need or problem. Individual ad-hoc meetings may be called if there is a necessary need or problem and will be coordinated between individual team members.

Wednesday team meetings will be used for retrospectives and any necessary updates to current practices.

### Who will own each of the components in your architecture? Owning them means being responsible for writing them and making sure they are functional and correct.

Owning them means being responsible for writing them and making sure they are functional and correct.
The following components are taken from the [Architecture Document](./ARCH.md) which describes each component in detail:

#### Home Screen

| __Component__                                                       |                                               __Owner__           |
| :------------------------------------------------------------: | :------------------------------------------------------------------: | 
| map | Matthew |  
| friendList | Matthew |
| currentUser | Ben |
| signOutModal | Matthew |
| signOutButton | Ben |
| friendsButton | Ben |
| friendsConnector | Matthew |

#### Friend Preferences

| __Component__                                                       |                                               __Owner__           |
| :------------------------------------------------------------: | :------------------------------------------------------------------: | 
| searchFriends | Ben |  
| receivedRequests | Charlye |
| backButton | Charlye |

#### Sign In/Sign Up

| __Component__                                                       |                                               __Owner__           |
| :------------------------------------------------------------: | :------------------------------------------------------------------: | 
| signUpForm | Joseph |  
| signInForm | Joseph |
| signUpButton | Joseph |
| signInButton | Joseph |

### By what date will you have a release candidate?

The release candidate will be ready by June 1st. We will dedicate the following four days for testing and fixing bugs. Our Bug Bash will take place on June 5th, where we will have real users test the application.

### What practices will you use to know if you're making progress toward that release candidate?

As we complete assigned components from GitHub projects, each developer will create comments and track progress as either todo, in-progress, in-review, or done.
At the beginning of all team meetings, the project manager will facilitate a quick developer check-in on their current tasks and uncover any blockers that they are facing. 
The technical lead (Ben) will code review all pull requests going into the master branch ensuring code quality. The technical lead will also communicate with the project manager once team pull requests are approved and tasks are completed.

### What practices will you follow to improve your process if it's not working?

We will keep our current weekly meeting time (Wednesday, 12:30-1:30) and use it as a team reflection and retrospective. When there are pain points, we will use this time to find new methodologies and tools that better fit our team and product. 
