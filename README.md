# Assignment

This Document help the reviewer to know more about the code.

## Architecture
### Mobile

##### ViewController:
A necessary component in iOS applications, I try to keep our ViewControllers as simple and dumb as possible, and 
delegate most of the logic to the Presenter, which coordinates between the various necessary components.

##### Presenter:
The Presenter is the main coordinator for a particular screen/feature. It obtains a models array from the UseCase and passes it along to the Displayer.
It also receives commands from the Displayer through the ActionListener, and then dispatches appropriate commands back to the UseCase or to the Navigator (Well In this application there is no such navigation present.).
The Navigator, Displayer and UseCase are all defined as protocols, allowing for easier testing of the Presenter logic (In this assigment I have not written unit test cases but It can be written.).

##### UseCase:
The UseCase combines data from various DataSources, user input to create a model. It is responsible for handling model and filter it from the other component and Pass it to the presenter.

#### Protocols

##### Navigator:
Responsible for creating new ViewControllers and pushing them unto the navigation stack (which it owns) or presenting them.

##### Displayer:
An abstraction of the view. It has methods for updating (with array of model) and for attaching an ActionListener. It can be implemented directly by the View, but could also be a separate component that has access to the View and/or ViewController if necessary.

##### DataSource:
Essentially, the ‘model’, as exposed to the Mobile layer. It provides dumb structs containing domain data and commands to enact on the domain.

##### ActionListener:
A struct that contains blocks to execute whenever a user action occurs. It is created by the Presenter and ‘attached’ to the Displayer, which then calls the relevant blocks when appropriate.
