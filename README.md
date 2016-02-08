# Job Matcher

The 'Tinder' of job seeking. 

### Job Seeker

You're in the middle of a job search? Build your profile and like some offers! Get noticed by the offer's author and connect!

### Recruiter

You're looking for the perfect candidate for your open position? Post some offers, like some profiles and get in touch!

### Main Idea

Job Mather offers an easy way to connect Job Seekers and Recruiters when there's mutual interest without having to go through rejections - nice, huh? The application will only 
connect the two sides if both express interest - the Job Seeker to one of the Recruiter's offers and the Recruiter - to the Job Seeker's profile. How does one do that? Just swipe right!
However, if one doesn't like what they see, swiping left is also an option.

Once connected, Job Seekers and Recruiters can exchange messages and figure out all the other details.

### Technologies

- Backend: Web API
- Client: iOS application

#### Gestures

- Swipe
- Tap
- Long tap
- Pinch

Swipe right or left to like or dislike profiles and job offers; long tap to change your profile image or add a phone number of a liked profile to your contacts; pinch to zoom in and out the profile images and tap for almost everything else.

#### Device APIs

- Connection
- Camera
- Contacts
- Geolocation

You need to be connected in order to use the app. Use your camera or photo library to change your profile image. Save a phone number of a liked profile to your cotacts. Add a job offer,
using your current location rather than having to type it.

#### Other

- SQLite used to store path to the user's profile image.
- ASP.net Web API for the backend logic.
- Background task to check if you're connected every ten minutes.

[Demo on YouTube](https://www.youtube.com/watch?v=CqDgQ1nTJjk)