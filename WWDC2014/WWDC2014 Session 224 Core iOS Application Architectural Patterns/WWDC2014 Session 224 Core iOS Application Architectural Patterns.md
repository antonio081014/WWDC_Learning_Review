## 1. Common Patterns
#### Target / Action
**What does it do**: Connect controls to custom logic
**Control** sends messages (**Action**) to the Object(**Target**)
![Graphic Demo](https://raw.githubusercontent.com/antonio081014/WWDC_Learning_Review/master/WWDC2014/WWDC2014%20Session%20224%20Core%20iOS%20Application%20Architectural%20Patterns/Screen%20Shot%202015-08-12%20at%202.03.09%20PM.png)
#### Responder Chain
**What does it do**: Handle events without knowledge of which object will be used
![Graphic Demo](https://raw.githubusercontent.com/antonio081014/WWDC_Learning_Review/master/WWDC2014/WWDC2014%20Session%20224%20Core%20iOS%20Application%20Architectural%20Patterns/Screen%20Shot%202015-08-12%20at%202.09.01%20PM.png)
If the 1st Responder doesn't respond, the message will keep passing until either some responder respond it or nothing happens(no responder).
![Graphic Demo](https://raw.githubusercontent.com/antonio081014/WWDC_Learning_Review/master/WWDC2014/WWDC2014%20Session%20224%20Core%20iOS%20Application%20Architectural%20Patterns/Screen%20Shot%202015-08-12%20at%204.08.25%20PM.png)
#### Composite
**What does it do**: Manipulate a group of objects as a single object
One great example is a parent view could have some subviews. When the parent view is moved or rotated, the subviews follows, be moved or rotated as well.
#### Delegation
**What does it do**: Customize behavior without subclassing
This pattern has been wildly used in a lot of places, e.g, `UITableViewDelegate`, `UITextFieldDelegate`, etc.
It simply tells the delegator some behavior has been operated. The more delegate methods provide, the more flexible and more informative it will be.
#### Data Source
**What does it do**: Customize data retrieval without subclassing
This pattern has also been used in a lot of places, e.g, `UICollectionViewDataSource`, etc.
It gives developer a way to reuse the same **View** for different **Controllers** with different purposes.
#### Model-View-Controller(**MVC**)
**What does it do**: Provide organizational structure to focus responsibilities
**What they are**:
- **Model**: It's the data.
- **View**: It's the thing displays the information to the user, it takes user action/control and turns them to the state changes.
- **Controller**: It takes data from Model and display it on the View, takes user's interaction in the View and turn it to state changes, then update it in the Model accordingly.

Other patterns could be mentioned here is: **Singleton Pattern**, **Facade Design Pattern**, etc.

## 2. Use them in Your Code

To build an Application, to design(overview, or conceptualize) the app:
1. Finding out the Definition of Application, and make it into the statement.

2. From the definition, extract the data model from all the nouns, and build the relationship from verbs used in this statement. There might be some potential relationship or assistant data model needed for the app, but core data model should be visualized easily from this definition statement.

3. View, displays the information model provides. Using composite pattern to structure efficient information and display to the user. Having a View Hierarchy will be very helpful to know which view component presents which part of information model provides.

4. In controller, using Data Source pattern if the view could be used in not just one place. and using Delegate to receive message when action has been taken on View. If there is any state change after the user interaction, the controller should update the model accordingly.

5. If several controllers use the same piece of code for the similar purpose, it's great to separate it out, and make a new class, so all the controllers who need it could use it without duplicate codes everywhere. (This applies to most of the **Communications**, e.g. Network, Bluetooth, etc.) Sometime, this is called refactor when taking out of the common part. Another great example is implementing **In-App-Purchase**, I have a singleton class to do all of the IAP things, so no two purchase operations could be made at the same time. Sure delegate methods are used here to send information back when user purchases successfully or failed, it would be great practice to let the user know the state of each interaction.

6. It's worthy to mention Facade Design Pattern, which could be used in Networking API class. Most of the apps need network communication with the backend, at first, the company is using like Parse.com backing service to provide all the information. So the most of its communication api will be Parse related APIs. While, as the company's user grow fast, using 3rd party service would not be a great if it's more expensive than having some one build your own. So, the code will be changed to adopt the new backing service(your own). Here is the thing, when a Facade Design Pattern used here, all the communications are wrapped in simple self-defined APIs, when backing service changed, the only thing to change is the implementation of Communication APIs, while the Design and Definition of the APIs would not be changed, so the caller (controllers) would not worry about changing code to adopting the new service. This is a great way to separate your code with direct communication APIs.