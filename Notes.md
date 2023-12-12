#  Notes
## Features To Create

* Weight Tracking
* Exercise History with weight, sets, and dates
* Workout history with combinations of exercises and their sets
* Body part history to show how often you are hitting various parts of your physique (based on exercise values)


### SwiftData Tips
- Create the workoutSet, then add it to the exercise history. Directly associating the exercise and history does not update the UI as well 
```swift
    let s = WorkoutSet(weight: Int.random(in: 50...300), reps: Int.random(in: 1...30), timestamp: randomTimestamp)
    exercise.history?.append(s)
    ```
- This may not update the UI immediately, but it works with the iCloud data better. To update the UI query on the workoutSets rather than the exercises when displaying them. [Reference](https://www.youtube.com/watch?v=un45CkTY5fM)


##  Shortcuts
* Jump to definition: control + command + J
* Highlight Occurences: command + D
* Move selection/line up and down:  option + up or option  + down
* Switch tabs command + shift + [
* Close tabs command + W
* build: control + command + B

## References
[Medium](https://github.com/emptybasket/anothertodo-app/blob/develop/Another%20ToDo%20App/Another%20ToDo%20App/Screens/AddToDoListItemScreen.swift)

[Helpful Demo Repo](https://github.com/gahntpo/SnippetBox-SwiftData/blob/main/SnippetBox/swift%20data/models/Folder.swift)

[SwiftData with CloudKit](https://www.youtube.com/watch?v=un45CkTY5fM)
