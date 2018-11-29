#In Tune
Mobile Code Challenge - HPS Gesundheitscloud.

## Outline

The application takes advantage of the iTunes search API to read song information. It parses the response into a table with the cells displaying the artwork, track name, artist name, year of the release, the length in minutes and seconds, and the price. 

On selecting the cell, it displays a full screen view with the same details as the cell but also the album or collection name. A button can open the track in iTunes Music on the iPhone. 

There is a simple music player at the base of the screen that will play the preview. On selecting the detail view, all the results are added to the queue, such that on tapping play, it will continue to play the next in the selection. 

Next and previous track is supported. The application will play music while it is in the background. 

Once the user displays the detail screen, the music player will still be visible on returning to the search screen, and has small amount of trasparency so that the items below are still visible. 

It supports social sharing with the available options depending on the user's phone configuration of social media. 

The search results screen has a basic level of sorting for price, genre and length. 

## Architecture 

At the root level, the application employs the coordinator pattern to remove the dependency between screens which enables the UI to be updated dynamically. In this project each screen is placed in a folder with all the associated files in the same place. 

The presentation layer uses the well-known Model-View-Presenter pattern, giving a clean seperation of concern between the view and parsing of the data. This was chosen for its simplicy and testability.

A wireframe structure is used to manage the dependency injection in the view controller and presenter.

The data provider class acts as a data access layer, which has extensions defined by protocols for each screen and the music player. This ensures that access to functions are restricted, and it facilitates unit and integration testing by mocking the data layer.

An AppData class is used to maintain global state across views. The data provider controls the access to this information. The view controllers only have read-only access, and the data can be changed using actions. This is form of uni-directional data flow, and helps to prevent inconsistencies in the screens and data presented. 

## Implementation 

The coordinator is in charge of what screens and views are displayed. The player view is added and controlled independently of the 2 screens, and is managed by the coordinator. 

The scrolling of the results is optimised by performing all the necessary parsing of data into an array of structures prior to displaying them. The artwork images are loaded asynchronously and cached. It uses a CocoaPod library for this. 

The player is based around the AVQueuePlayer class. It takes an array of AVPlayerItems as an input, and can play the next item once one finishes. It does not support going back to the previous item however. This has been implemented by delting the queue of player items, and building it back again placing the new item at the beginning. 

On loading player items, an asychronous caching process is done to preload the metadata which results in smooth playback of the queue.

## Automated testing
The app has good test coverage for the networking layer, the model and parsing layer, and some UI testing for searching and playing a file. 

## Known Issues
There seems to be a memory leak related to the UI keyboard prediction view. I haven't found a way to disable it. 
 
There seems to be an issue with matching the song with the audio stream being played.

## Improvements

On selecting a song to play there is an initial lag before it plays. Although it does show the loading progress icon in the status bar, this is not very prominent. It would be better to display a larger spinner to make the process clearer. 

When loading errors happen while steaming this is not shown to the user, and a user would perceive it as not working. In general it is best to keep the user informed at all times about connection issues so that the user can possibly act upon this information and perhaps relocate or use a better connection. 

The previous button loads all the songs into the memory cache again. This could be optimised to re-use the previously loaded songs.

It would be nice to add a force touch to the search results, and to the music player view. 