# ERTextlimit

[![CI Status](http://img.shields.io/travis/earlred/ERTextlimit.svg?style=flat)](https://travis-ci.org/earlred/ERTextlimit)
[![Version](https://img.shields.io/cocoapods/v/ERTextlimit.svg?style=flat)](http://cocoapods.org/pods/ERTextlimit)
[![License](https://img.shields.io/cocoapods/l/ERTextlimit.svg?style=flat)](http://cocoapods.org/pods/ERTextlimit)
[![Platform](https://img.shields.io/cocoapods/p/ERTextlimit.svg?style=flat)](http://cocoapods.org/pods/ERTextlimit)


![alt text](screenshots/textfield.png "UITextField use")
![alt text](screenshots/textview.png "UITextView use")
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
Swift 3

## Installation

ERTextlimit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ERTextlimit'
```

In your viewcontroller add:

Import ERTextlimit

Then on viewDidLoad:

[UITextField].showCharactersLeft(maxChars: n)
or
[UITextView].showCharactersLeft(maxChars: n)
or
[UITextView].showCharactersLeft(maxChars: m, timeVisible: seconds, xOffset: 0, yOffset: 0, messageType: .Remaining)



Examples:

self.textField.showCharactersLeft(maxChars: 30)

self.textView.showCharactersLeft(maxChars: 50)





## Author

EarlRed

## License

ERTextlimit is available under the MIT license. See the LICENSE file for more info.
