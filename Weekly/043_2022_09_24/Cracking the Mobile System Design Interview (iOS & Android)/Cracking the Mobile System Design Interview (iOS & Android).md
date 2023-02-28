[Original Link](https://themobileinterview.com/cracking-the-mobile-system-design-interview/)

# Cracking the Mobile System Design Interview (iOS & Android)
## Introduction
Preparing and facing something brief and short, in the lines of:
* Design a photo-sharing app (i.e. Instagram)
* Design a messenger app (i.e. WhatsApp or Messenger)
* Design a newsfeed feature (like in Twitter)

## Interviewer’s perspective
* Your ability to navigate an ambiguous problem by asking the right questions
* Your thinking process: How you break a large problem into smaller parts
* How you make decisions, evaluating different alternatives and the trade-offs
* Your knowledge. Can you also propose a solution for the server?
* Your communication and collaboration skills. How you synthesise your solution and get buy-in

## The approach

### Understand the problem
* Just don't jump to conclusions    
* A few questions
    - What are we being asked to design?
    - Who is the user, and how will they use our system?
    - What's the initial number of users? And the expected growth?
    - Are we being given an initial design/wireframes, or should we produce them as well?
    - Are we designing an MVP or final-product?
    - Are we building this from scratch, or can we leverage any existing components? 
    - Any existing patterns/architecture we should follow?
    - How big is the team who will implement and maintain our system?
    - Are we expected to design just the mobile application or other parts of the overall system too (e.g. API)?
    - Is it iOS or Android only, or cross-platform? Shall we support smartphones, tablets, both?

### Define the scope
* Figure out and agree on the functional requirements
* Think of similar famous apps or systems
    - What features they offer
    - What's their primary functionality
* Suggest many potential features and seek agreement with the interviewer    
    
### Identify technical requirements
#### Networking

#### Security


#### Availability


#### Scalability


#### Performance

#### Testing

#### Monitoring

#### Deployment

### Propose a high-level design

#### Wireframe the main flow (if not provided)


#### Draw the principal systems (if required)

#### Define basic data entities

#### Describe the primary endpoint(s) (if required)

#### Propose the client architecture


### Deep-dive into one component
#### The approach
* __Choose the most interesting screen and draw its architecture__
    - Cover all layers from the different UI components, VMs, Repos, Endpoints/Sockets, Network Layer, Local Store, etc.
* __Trace the dependencies (draw arrows from the caller)__
* __Walk over the flow from the user's point of view__
* __Explain the Data flow__
* __Go in-depth into one component:__ Think about what might be the most challenging parts, if the design may have any bottlenecks, etc. For example:
    - "Real-Time" updates
    - Image Caching (challenges, NSOperation Queue)
    - Reusing Cells (preparing VMs)
    - Buffering data requests to improve UX


### Wrap up
* A quick recap of your design
* Follow-up questions/stretch goals
* Further refinements and considerations

## Final thoughts
### General advice
* Do not be afraid to ask
* Validate your assumptions
* Know and use your tools
* Share your thoughts
* Get buy-in for your choices: For every decision
    - Mention the different alternatives you consider
    - Their strengths and weaknesses
    - Trade-offs

### Practice, practice, practice
* Get familiar with different standard architectures
    - MVC, MVVM, MVP, Redux, VIPER, etc.
* Design common apps
    - Mail client, Instagram, Spotify, Twitter, Facebook, WhatsApp, Etsy
* Read about existing solutions
* Review a few well-known open-source projects.
* Ask friends and colleagues
* Practice mock interviews

## So, about that coming interview
* Mobile system design interviews are like a puzzle
    One you have never built before, but you get to bring the parts to solve it.
* Pay attention to the small hints and suggestions your interviewer gives you

    

