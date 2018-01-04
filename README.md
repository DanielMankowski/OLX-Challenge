# OLX-Challenge
This is an example project as interview processing of OLX company.
## Project Architecture
I have chosen MVC architecture to make the project, always trying to meet SOLID metodology. For that I was tried to separate responsabilities of each screen like so flow among screens of differents ViewControllers.
If you are intersting, this an article about that: [A Better MVC](https://davedelong.com/blog/2017/11/06/a-better-mvc-part-1-the-problems/)
## Technical Details
In order to demonstrate knowledgment I think that the most appropiate way to do the project is as native as possible, so I am going to list the components that I have used and what library I could have used.
- For API calls: **URLSession and URLSessionTask**. Both are executed in background y implements cache by default. I could have use Alamofire or AFNetwork
- For data persistece: I have used native data filesystem of device and save it as a plist, although in this project type given that items to show and its states (price/disponibility) are variables, in my opinion it is not make sense to persist the data in device.
- For download images: I have used Nuke libreary, added to project by CocoaPods. (when dowload proyect, please do not foget to execute pod install in console)
## Requirements
I have tried to cover all requerimients requested:
- Paging
- Item detail
- Pull to refresh
- Custom protocol (at the moment to select a cell when comunicate with ViewController in charge of flow)
- Disk Persistence
- Images cache
- Portrait/Landscape
## Clarifications/Improvements
By time reasons in screens are missing refreshs (UIActivityIndicator) and show error messages if some error happens. By example at the moment to call API (UIAlertController).
Besides, a good idea could be improve collectionview where images are showing, the cell could be ajusted depends of images size.
Search Bar coud disappear when scrolling.
And so on
