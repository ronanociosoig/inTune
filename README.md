[![Build Status](https://travis-ci.org/ronanociosoig/inTune.svg?branch=master)](https://travis-ci.org/ronanociosoig/inTune)
[![codecov.io](https://codecov.io/github/ronanociosoig/inTune/coverage.svg?branch=master)](https://codecov.io/github/ronanociosoig/inTune?branch=master)
[![CircleCI](https://circleci.com/gh/ronanociosoig/inTune.svg?style=svg)](https://circleci.com/gh/ronanociosoig/inTune)
[![codebeat badge](https://codebeat.co/badges/ef478c94-9b65-481f-a9ec-4a7185867400)](https://codebeat.co/projects/github-com-ronanociosoig-intune-master)
##In Tune

### Outline

The app searches the iTunes API and lists out songs, and can play the previews continuously in a playlist. Tap on one, and it keeps going. It plays in the background too! Nice.

The app displays a table with the cover artwork, track name, artist name, year of the release, length, and the price. 

Selecting sort gives options to sort the results according to artist, album, price, length, genre, and year.

Tap an item to show more details. here you can also open the track directly in iTunes Music. 

The music player at the base of the screen plays the preview. 

On selecting the detail view, all the results are added to the music player queue, tap on play and it will continue to play all the previews.

On returning to the search screen, the music player will still be visible on top of the results table (with a small touch of blur).

Sharing the track details from the details screen. 

### Architecture 

At the root level, the application employs the coordinator pattern to remove the dependency between screens which enables the UI to be updated dynamically. In this project each screen is placed in a folder with all the associated files in the same place. 

The presentation layer uses the well-known Model-View-Presenter pattern, giving a clean seperation of concern between the view, state and the data.

A wireframe structure is used to manage the dependency injection in the view controller and presenter.

The data provider class acts as a data access layer, which has extensions defined by protocols for each screen and the music player. This ensures that access to functions are restricted, and it facilitates unit and integration testing by mocking the data layer.

An AppData class is used to maintain global state across views. The data provider controls the access to this information. The view controllers only have read-only access, and the data can be changed using actions. This is form of uni-directional data flow, and helps to prevent inconsistencies in the screens and data presented. 

### Implementation 

The coordinator is in charge of what screens and views are displayed. The player view is added and controlled independently of the 2 screens, and is managed by the coordinator. 

The scrolling of the results is optimised by performing all the necessary parsing of data into an array of structures prior to displaying them. The artwork images are loaded asynchronously and cached. It uses a CocoaPod library for this. 

The player is based around the AVQueuePlayer class. It takes an array of AVPlayerItems as an input, and can play the next item once one finishes. It does not support going back to the previous item however. This has been implemented by deleting the queue of player items, and building it back again placing the new item at the beginning. 

On loading player items, an asychronous caching process is done to preload the metadata which results in smooth playback of the queue.

## Automated testing
The project has tests to cover unit, integration and UI tests. It also has KIF UI testing. Note that running all the tests together will probably fail - especially the KIF tests.  

## Known Issues
There seems to be a memory leak related to the UI keyboard prediction view.

Running all the KIF tests as once will fail. Running them separately works. 

The player does not behave correctly when running in the simulator. Tapping pause does not always pause the current song. It works perfectly on the device.

## Improvements

It would be nice to add a force touch to the search results, and to the music player view.

Add songs to a favorits list. 

Show search history. 

Open song preview pages. 

Show currently playing song in the search results with a progress. 
