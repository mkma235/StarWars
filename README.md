# StarWars - Mariano Manuel Keymurth  

## (0)Synopsis  

**(0.1)To Compile:**  
Type "command+B" in your Xcode project to compile the program.  

**(0.2)To Run:**  
Type "command+R" in your Xcode project to run the program.  

**(0.3)Input:**   
There is no input needed to initiate the program.  

**(0.4)Output:**  
A collection view displaying Star Wars theme card events are displayed to the user in a single column grid. If a user is on an iPad or changes device orientation on iPhone, then the collection view cells will be presented in a two column grid fashion. The user can scroll through the collection of Star Wars card events. The user can also click on an event to read a more in-detail synopsis of the event and screen capture the detailed view of the collection event.  

## (1)Included Files  
README.md - This file  
AppDelegate.swift - Project Entry Point  
CardCell.swift - CollectionView Cell  
CardService.swift - API Call Service  
DetailView.swift - Star Wars Details Page  
Info.plist - App Settings  
MasterView.swift - Star Wars Collection View  
MemCard.swift - Model Struct  
MemoryCard+CoreDataClass.swift - MemoryCard Entity Class  
MemoryCard+CoreDataProperties.swift - MemoryCard Entity Property Variables  
SceneDelegate.swift - App Lifecycle Delegate  
Info.plist - XCTests Settings  
StarWarsTests.swift - XCTests file for testing functionality  
Info.plist - XCUITests Settings  
StarWarsUITests.swift - XCUITests file for testing UI/UX  

## (2)Bugs/Limitations  
A potential limitation noted in the program is that the app does not handle cases where there is no connectivity. During the very first load of data from the API call, if there is an interruption in the connectivity-there will be missing data such as missing images for certain collection view cells unless the app is reinstalled. Another limitation that is noted is that the storyboard contains about 15 warnings due to ambiguous contrainsts. However, attempting to fix these warnings causes the collection view to lose its form.  

## (3)Description  
This program provides a collection view of cells that are themed after certain Star Wars events. Each event contains a date, a title depicting the event, a location, and an overview of the event. Everything but the overview is displayed completely on each cell of the collection view. In order to read more about the event, the user must click on the event cell to open up a detailed view of the event which contains basically the same information except with a full overview of the Star Wars event. When clicking on a collection view cell event, a detailed view is shown along with a small icon on the top right corner of the navigation bar. This button will allow the user to share a screenshot of the information contained in the detailed view via SMS, Social Media, or Email. The program is pretty simple however it's pretty difficult to implement considering it has to be compatible with iOS 13 AND work on iPhone and iPad. There's a lot of little things here and there that must be accounted for in order to make sure the program is working optimally and as smoothly as possible.  

## (4)Modifications  
A clear modification made to the program was the height alteration made to the second view controller in the application-which is the detail view controller. It was difficult to figure out how to dynamically change the view controller's height based on the text provided by the API call which varied per collection view celli. The best way to remedy the situation was to extend the height of the DetailView controller so that it covered the largest posible text from the API calls so that the scroll view worked for all text from the API calls. The modification worked but it was not the most desirable of fixes. Can be improved.  

## (5)Example  

**(5.1)Input:**  
No input is needed.  

**(5.2)Computation:**  
As app launches, the application begins an API call which begins loading all the Star Wars theme information along with its image data. A progress view is displayed to show the user that the app is working and not sitting idle. Dates, titles, locations, and overviews are all downloaded from the API call and stored locally on a local variable model. Once the API call is complete, the application proceeds to rewrite all the information received from local data into persistent storage so that the data can be stored on the devices hard drive memory. This allows the application to run more smoothly and allows the application to skip having to call the API service a second time if the user were to close the app for any reason. The collection view is displayed to the user. They can click on a collection view cell to view a detailed view of the Star Wars theme desired and can choose to share that information if so desired.  

**(5.3)Output:**  
A collection view of Star Wars theme cells appear. Can be selected to view full content in a detailed view. Can also share image data of detailed view via SMS, Social Media, or Email. Collection View adapts to size of device whether it be an orientation change in iPhone or changing to a larger device like iPad.  

## (6)Testing  

**(6.1)Experimental Setup:**  
For XCTests, a URLSession is initiated along with providing a sample API URL for the functionality tests. For XCUITests, a XCUIApplication was launched.  

**(6.2)Tests:**  

######  (6.2.1)testValidHTTPStatusCode200  
This test makes an API call and the status code is tested. If the status code is a 200 code, then the test passes. The API call tested is a search for Star Wars theme events.  

######  (6.2.2)testAPICallCompletes  
This test makes an API call and the completion handler is tested. If the completion handler is invoked, then the test passes. The test also checks that no error was thrown. The API call tested is a search for Star Wars theme events.  

######  (6.2.3)testLoadingService  
This test checks the UI/UX layout of the application. The test begins by waiting for the API data to load then begins scrolling through the collection view cells displayed to the user. When the bottom is reached, a cell is checked for existence and is checked to be hittable. Then, the test begins to scroll back up through the collection view cells displayed. Once again, a cell is checked for existence and is checked to be hittable. The orientation of the phone is changed to landscape just to check that the collection view can display the cells in a two column fashion before the test exits in completion with successful ratings.  

######  (6.2.4)testMasterDetailViews  
This test checks if the app can properly move from one view to another. The test begins by scrolling down to the bottom of the collection view and selecting one of the cells (the one with the longest text overview). The test asserts that the proper cell was chosen. Then the test begins to scroll through the overview to make sure that the entire text can be readable from start to finish. Once the test reaches the end of the overview text, the test scrolls back up to the top of the detail view of that specific chosen collection view cell. Then, the test looks for the back button available in the navigation bar at the top of the screen and asserts its existence and also checks that it is hittable. The test finishes by clicking on the back button and scrolling back up the collection view cells, ending with successful ratings.  

######  (6.2.5)testSaveCapture  
This test checks if the app can properly use the share button available in the detail view portion of the app and also checks if an image capture can be saved to the Photo Library. 
The test begins by selecting one of the the collection view cells displayed on the screen after launch. The test then asserts that the desired cell was chosen by asserting the proper title and location of the cell were checked for existence. Next, the test checks to see if it can locate the share button at the top right of the navigation bar and asserts the share button's existences and also checks if it is hittable. If those asserts pass, the share button is tapped and the share options are revealed to the user. The test then looks for the "Save Image" button located in the share options and is asserted for existence and hittability. Finally, the "Save Image" button is tapped so the detail view imaged can be saved to the iPhone/iPad Photo Library. The test concludeds with successful ratings.  

**(6.3)Analysis:**  
There were two main coding setback to this program. One setback was making a dynamic scrollview for the detail view when displaying the overview text to the user. There was issues finding a way to create a dynamic scrollview for the detail view controller when displaying the full overview text generated by the API call. Each overview text had different lengths and it was hard to estimate a proper size for the height of the detail view that would cover all the sizes for the overview texts. The best solution that worked was to extend the height of the detail view to match the longest API call text received. This made it possible to scroll through all the text but left a lot of empty space in most detail views. The lack of experience with storyboards also accounted to the fact that one could not resolve this dynamic scrollview issue with a better solution. The other setback was the 15 warnings or so mentioned in the storyboard. There was a lot of ambigous contrainsts due to many constrainsts recieving the same priority as well as having been assigned fixed widths and heights along with leading/trailing/top/bottom constrainsts with the same priority. This left the interface builder wondering which constraint took precedence over the other. However, when an attempt was made to resolve these warnings, the structure of the collection view began to come undone and the cells no longer contained the information that they needed to properly display so a decision was made to simply keep the warnings instead of resolving them. Again, lack of experience with storyboards contributed to these situations. New techniques like SwiftUI make these problems much more avoidable and much more simplified.  
