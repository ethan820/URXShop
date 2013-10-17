## Demo app for URX and Parse integration

-Follow this guide to setting up URX Turnpike end-to-end by, creating a simple Web app that deeplinks into a Turnpike-enabled iOS app.

=======

# Quickstart

## Seed sample products on Parse

1. Create a new app on Parse named ParseStore
2. Add the new Parse Application ID and REST API key to Install/install.sh (Very important that you use the REST API key here)
3. Using Terminal, cd into the provided Install folder, and run "sh install.sh"
4. Checkpoint: via the data browser, verify a class named "Item" is created on the Parse app. There should be 3 products in this class: T-shirt, hoodie, and mug. There should be an image associated with each product.

## Get your iOS app up and running

1. Add the Parse Application ID and Parse Client API key to /Store/Resources/Development.xcconfig and /Store/Resources/Distribution.xcconfig
2. In XCode, choose Clean from the Product menu.
3. Checkpoint: run your app in the simulator; you should see the products via your app. You cannot buy yet.

## Get your Web app up and running


## Voila! You're done.
