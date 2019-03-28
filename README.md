#In Tune

## Outline

The app searches the iTunes API and lists out songs, and can play the previews continuously in a playlist. Tap on one, and it keeps going. In the background too! Nice.

The app displays a table with the artwork, track name, artist name, year of the release, the length in minutes and seconds, and the price. 

Selecting the sort option gives options to sort the table according to artist, album, price, length, genre, and year.

Tap the cell to show more details. You can also open the track directly in iTunes Music. 

The music player at the base of the screen that will play the preview. 

On selecting the detail view, all the results are added to the music player queue, tap on play and it will continue to play all the previews.

Next and previous track is supported. 

Did I say that the application will play music while it is in the background? I did, but it's nice you know.

On returning to the search screen, the music player will still be visible on top of the results table (with a small touch of blur).

You can share the track details from the details screen. Useful! 

## Architecture 

At the root level, the application employs the coordinator pattern to remove the dependency between screens which enables the UI to be updated dynamically. In this project each screen is placed in a folder with all the associated files in the same place. 

The presentation layer uses the well-known Model-View-Presenter pattern, giving a clean seperation of concern between the view, state and the data.

A wireframe structure is used to manage the dependency injection in the view controller and presenter.

The data provider class acts as a data access layer, which has extensions defined by protocols for each screen and the music player. This ensures that access to functions are restricted, and it facilitates unit and integration testing by mocking the data layer.

An AppData class is used to maintain global state across views. The data provider controls the access to this information. The view controllers only have read-only access, and the data can be changed using actions. This is form of uni-directional data flow, and helps to prevent inconsistencies in the screens and data presented. 

## Implementation 

The coordinator is in charge of what screens and views are displayed. The player view is added and controlled independently of the 2 screens, and is managed by the coordinator. 

The scrolling of the results is optimised by performing all the necessary parsing of data into an array of structures prior to displaying them. The artwork images are loaded asynchronously and cached. It uses a CocoaPod library for this. 

The player is based around the AVQueuePlayer class. It takes an array of AVPlayerItems as an input, and can play the next item once one finishes. It does not support going back to the previous item however. This has been implemented by deleting the queue of player items, and building it back again placing the new item at the beginning. 

On loading player items, an asychronous caching process is done to preload the metadata which results in smooth playback of the queue.

## Automated testing
The project has tests to cover unit, integration and UI tests. It also has KIF UI testing. Note that running all the tests together will probably fail - especially the KIF tests.  

## Known Issues
There seems to be a memory leak related to the UI keyboard prediction view.

Running all the unit tests will fail. Running them separately works. 

## Improvements

On selecting a song to play there is an initial lag before it plays. Although it does show the loading progress icon in the status bar, this is not very prominent. It would be better to display a larger spinner to make the process clearer. 

When loading errors happen while steaming this is not shown to the user, and a user would perceive it as not working. In general it is best to keep the user informed at all times about connection issues so that the user can possibly act upon this information and perhaps relocate or use a better connection. 

The previous button loads all the songs into the memory cache again. This could be optimised to re-use the previously loaded songs.

It would be nice to add a force touch to the search results, and to the music player view. 