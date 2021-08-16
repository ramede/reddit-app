# Reddit-app

This is a single view app designed to load reddit posts from [Reddit API](http://www.reddit.com/dev/api).\
This is a iOS study that covered some important foundations like VIP architecture, View Code, UITableView, UISlipViewController, URLSession and Unit Test.

**Xcode Version**: 12.5.1\
**Swift Version**: 5

## Features

- [x] Get top reddit posts
- [x] Pull to refresh
- [x] Pagination support
- [x] Indicator of unread/read post (updated status, after post it’s selected)
- [x] Dismiss Post Button (remove the cell from list)
- [x] Dismiss All Button (remove all posts)

## TODOs

- [ ] Create service layer to abstract Networking Dispatcher;
- [ ] Creating a URL and Request builder;
- [ ] Saving pictures in the picture gallery
- [ ] App state-preservation/restoration


## Dependencies

[CocoaPods](https://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries. So this is required to runing the project.

After installing CocoaPods running this command from root project folder to install dependencies:

```
$ pod install     
```

## CocoaPods Dependencies

### SDWebImage
- [SDWebImage](https://github.com/SDWebImage/SDWebImage) is a library that provides an async image downloader with cache support. For convenience, they added categories for UI elements like UIImageView, UIButton, MKAnnotationView.



## Final remarks

Make with ♥️   
if you have some suggestions please, let me know.

By Râmede
