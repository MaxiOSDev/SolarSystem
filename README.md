# SolarSystem
NASApp project for Teamtreehouse's Techdegree Program.

This is an iPad capstone project involving the following:
* Good Object Oriented Design and implementation (e.g. proper usage of classes, structs, composition, inheritance, protocols, and extensions)
* Efficient API consumption (e.g. Are asynchronous networking calls being used?)
* UI layout is clean and professional and user workflow is intuitive; App icon is setup properly
* Error handling is robust
* Sufficient Unit Testing is included
* App performance is good (e.g. User does not need to wait more than a couple of seconds for each action)
* Code is organized with with useful comments

A few third-party libraries were used, using cocoapods.
Below is how to install and configure it properly on your machine.

If you do not have CocoaPods installed, a dependency manager for Cocoa projects, you can install it with the following command:

`$ gem install cocoapods`

To intergrate all pods that have perhaps do not show up in the `Podfile`, set it up like so:

```platform :ios, '9.0'

target 'SolarSystem' do
  use_frameworks!

  # Pods for SolarSystem
pod 'Nuke'
pod "JLStickerTextView", :git =>
"https://github.com/luiyezheng/JLStickerTextView.git"
pod 'Alamofire', '~> 4.7'

end
```

Then simply commit the following command:
`pod install`
