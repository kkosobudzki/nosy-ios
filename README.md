# NosyNetwork iOS framework

## Building

To build an `NosyNetwork.xcframework` run following commands on main project directory:

```
xcodebuild archive \
-scheme NosyNetwork \
-destination "generic/platform=iOS" \
-archivePath ../output/NosyNetwork \
SKIP_INSTALL=NO
```

```
xcodebuild archive \
-scheme NosyNetwork \
-destination "generic/platform=iOS Simulator" \
-archivePath ../output/NosyNetwork-Sim \
SKIP_INSTALL=NO
```

and finally merge them into `xcframework` (make sure to remove results of previous xcframework build):

```
xcodebuild -create-xcframework \
-framework ../output/NosyNetwork.xcarchive/Products/Library/Frameworks/NosyNetwork.framework/ \
-framework ../output/NosyNetwork-Sim.xcarchive/Products/Library/Frameworks/NosyNetwork.framework/ \
-output ../output/NosyNetwork.xcframework
```
