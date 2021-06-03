# StarWars - Mariano Manuel Keymurth

## (0)Synopsis

**(0.1)To Compile:**  
Type "command+B" in your Xcode project to compile the program.  

**(0.2)To Run:**  
Type "command+R" in your Xcode project to run the program.  

**(0.3)Input:** 
A text input is needed to initiate the program. The user is provided with a SearchBar to perform the search.    

**(0.4)Output:**  
A collection view displaying products relevant to the given search terms is displayed to the user in a grid. A product image, product name, and product price is displayed. The user can scroll through the collection of products available.  

## (1)Included Files
README.md - This file  
Info.plist - App Settings  
Persistence.swift - Core Data Persistence Container  
ProductListing.swift - View displaying SearchBar and collection of products  
ProductSearchApp.swift - App Starter File  
Search+CoreDataClass.swift - Search Entity Class  
Search+CoreDataProperties.swift - Search Entity Property Variables  
SearchService.swift - API call service  
SearchView.swift - View implementing SearchBar and Product Search  
Info.plist - XCTests Settings  
ProductSearchTests.swift - XCTests file for testing functionality  
Info.plist - XCUITests Settings  
ProductSearchUITests.swift - XCUITests file for testing UI/UX  

## (2)Bugs/Limitations
A potential limitation noted in the program is that the app does not handle cases where there is no connectivity. No search is performed if there is no connection and no products can be shown to the user.  

## (3)Description
This program provides a product search for the given search terms provided by the user. Each search is stored on the device so the user can keep track of their search history. The search terms can also be deleted if needed. Once the user provides search terms, an API call is performed to fetch the list of relevant products availble to the user. A collection of products is displayed in a grid fashion to the user and the user can scroll through the collection of products. If it is the first time the user is performing a search, a linear ProgressView is displayed to the user to show the the products are being loaded for the user. This is shown because originally, there are no products being displayed to the user. Once the first search is performed, a circular ProgressView is shown to the user for a short amount of time to let the user know the next set of products is being loaded. This happens because the search is performed in the background while allowing the user to still browse the current collection of products, minimizing wait time.  

## (4)Modifications  
The app view was modified to show a linear ProgressView to let the user know that the app is still working. Originally, no activity indicator was displayed leaving the user to possibly think that the app had become unresponsive. To avoid this, a loading view was implemented to let the user know how much of the product data still needed to be loaded.  

## (5)Example

**(5.1)Input:**  
In the SearchBar, type 'Nintendo' and click the return key.  

**(5.2)Computation:**  
Once the search terms have been inputted, the app performs a for loop to check if the search had been searched before. If it is a new search, the search terms are stored on device so the user can have a record of the search history. Then, an API call fetches the list of products available to the user. With a second for loop, the results are assigned to properties in the view so that the view can display the products to the user. A concurrent thread is used to perform these calculations to avoid app unresponsiveness. Once the search is completely loaded in the background, the view is updated to show the products.  

**(5.3)Output:**  
A collection of products relevant to Nintendo such as video games and toys is shown to the user in a grid fashion.  

## (6)Testing

**(6.1)Experimental Setup:**  
For XCTests, a URLSession is initiated along with providing a sample API URL for the functionality tests. For XCUITests, a XCUIApplication was launched.  

**(6.2)Tests:**  

######	(6.2.1)testValidHTTPStatusCode200
This test makes an API call and the status code is tested. If the status code is a 200 code, then the test passes. The API call tested is a search for Nintendo products.  

######	(6.2.2)testAPICallCompletes
This test makes an API call and the completion handler is tested. If the completion handler is invoked, then the test passes. The test also checks that no error was thrown. The API call tested is a search for Nintendo products.  

######	(6.2.3)testSearchBarLayout
This test checks the UI/UX layout of the application. The implemented SearchBar is checked for existence and is checked to be hittable. The SearchBar is tapped and its corresponding Cancel button is checked to be hittable. If so it is tapped. Once again the Searchbar is tapped but this time the search term "Mario" is entered. Finally, the activity indicator is checked to have been displayed to the user. If everything is displayed properly, the test passes.  

######	(6.2.4)testProductListingLayout
This test checks if the app can properly move from one view to another. The search term "Nintendo" is entered but this time, the loading screen is not checked. The test waits for the products to load and then checks that a scrollView is displayed. If the test can properly swipe through the collection of products, the test continues without failing. Next, the SearchBar is tapped one last time in order to check the search history. The test looks for the search "Nintendo" after verifying that a search history list is displayed to the user. The test then attempts to delete that entry in the list. If all these procedures are performed properly, then the test passes.    

**(6.3)Analysis:**  
There were not many coding setbacks to this program. After coding the API call, there were some issues with app responsiveness that arose from fetching the product data. To remedy this, concurrent threading needed to be implemented. This allowed for the API fetching process to run in the background while the user browsed through the current collection of available products. When the data fetch was complete, then the UI/UX was updated accordingly. Another issue that was noted was that the product names were quite long. This caused the collection grid to become uneven. To fix this, a 3 line limit was placed on the names in order to better align all the products together. For the testing, there were two seperate tests for the UI/UX. This was done in order to check the initial loading screen when no products are shown to the user. The time intervals were too short to be able to check both the ProgressView and the ScrollView one after the other in the same test. Breaking it down made testing the app functionality easier. A potential update to the app could be adding the last search of products onto the Core Data Database so that the user has something to browse after having closed out of the app in the past. This could replace the loading screen at the beginning and keep the user more active with the app.   
markofnobody@Marianos-MacBook-Pro ProductSearch % >....                                                                                                                              
## (5)Example

**(5.1)Input:**
In the SearchBar, type 'Nintendo' and click the return key.

**(5.2)Computation:**
Once the search terms have been inputted, the app performs a for loop to check if the search had been searched before. If it is a new search, the search terms are stored on device so the user can have a record of the search history. Then, an API call fetches the list of products available to the user. With a second for loop, the results are assigned to properties in the view so that the view can display the products to the user. A concurrent thread is used to perform these calculations to avoid app unresponsiveness. Once the search is completely loaded in the background, the view is updated to show the products.

**(5.3)Output:**
A collection of products relevant to Nintendo such as video games and toys is shown to the user in a grid fashion.

## (6)Testing

**(6.1)Experimental Setup:**
For XCTests, a URLSession is initiated along with providing a sample API URL for the functionality tests. For XCUITests, a XCUIApplication was launched.

**(6.2)Tests:**

######  (6.2.1)testValidHTTPStatusCode200
This test makes an API call and the status code is tested. If the status code is a 200 code, then the test passes. The API call tested is a search for Nintendo products.

######  (6.2.2)testAPICallCompletes
This test makes an API call and the completion handler is tested. If the completion handler is invoked, then the test passes. The test also checks that no error was thrown. The API call tested is a search for Nintendo products.

######  (6.2.3)testSearchBarLayout
This test checks the UI/UX layout of the application. The implemented SearchBar is checked for existence and is checked to be hittable. The SearchBar is tapped and its corresponding Cancel button is checked to be hittable. If so it is tapped. Once again the Searchbar is tapped but this time the search term "Mario" is entered. Finally, the activity indicator is checked to have been displayed to the user. If everything is displayed properly, the test passes.

######  (6.2.4)testProductListingLayout
This test checks if the app can properly move from one view to another. The search term "Nintendo" is entered but this time, the loading screen is not checked. The test waits for the products to load and then checks that a scrollView is displayed. If the test can properly swipe through the collection of products, the test continues without failing. Next, the SearchBar is tapped one last time in order to check the search history. The test looks for the search "Nintendo" after verifying that a search history list is displayed to the user. The test then attempts to delete that entry in the list. If all these procedures are performed properly, then the test passes.

**(6.3)Analysis:**
There were not many coding setbacks to this program. After coding the API call, there were some issues with app responsiveness that arose from fetching the product data. To remedy this, concurrent threading needed to be implemented. This allowed for the API fetching process to run in the background while the user browsed through the current collection of available products. When the data fetch was complete, then the UI/UX was updated accordingly. Another issue that was noted was that the product names were quite long. This caused the collection grid to become uneven. To fix this, a 3 line limit was placed on the names in order to better align all the products together. For the testing, there were two seperate tests for the UI/UX. This was done in order to check the initial loading screen when no products are shown to the user. The time intervals were too short to be able to check both the ProgressView and the ScrollView one after the other in the same test. Breaking it down made testing the app functionality easier. A potential update to the app could be adding the last search of products onto the Core Data Database so that the user has something to browse after having closed out of the app in the past. This could replace the loading screen at the beginning and keep the user more active with the app.
