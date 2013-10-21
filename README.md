URXShop
=======

Demo app for URX and Parse integration

-Follow this guide to setting up URX turnpike-ios router end-to-end by, creating a simple Web app that deeplinks into a Turnpike-enabled iOS app.

=======

# Quickstart

## Seed sample products on Parse

1. Create a new app on Parse named URXShop
2. Add the new Parse Application ID and REST API key to Install/install.sh (Very important that you use the REST API key here)
3. Using Terminal, cd into the provided Install folder, and run "sh install.sh"
4. Checkpoint: via the data browser, verify a class named "Item" is created on the Parse app. There should be 3 products in this class: T-shirt, hoodie, and mug. There should be an image associated with each product.

## Get your iOS app up and running

1. Add the Parse Application ID and Parse Client API key to /Store/Resources/Development.xcconfig and /Store/Resources/Distribution.xcconfig
2. In XCode, choose Clean from the Product menu.
3. Checkpoint: run your app in the simulator; you should see the products via your app. You cannot buy yet.

## Get your Web app up and running
1. Navigate to the Settings/Web hosting tab on Parse.com (i.e.: https://parse.com/apps/urxshop/edit#hosting)
2. Choose a subdomain for your web app, and enter it in the field "ParseApp Name."
3. Open a terminal window and navigate to the cloudCode directory in your URXShopWorkspace. Run the command "parse deploy" to deploy your web app code to the Parse server (note: if you haven't already installed the Parse CLI, you'll have to do so first by running "curl -s https://www.parse.com/downloads/cloud_code/installer.sh | sudo /bin/bash". See: https://parse.com/docs/cloud_code_guide).
4. Open the Safari web browser from your iOS Simulator, and navigate to "your-parseapp-subdomain.parseapp.com." You should see a skeleton URX Shop web app with links to "Buy a Black Shirt" and "See your Shopping Cart."
5. If you have properly set up the iOS app, when you click either of these links you should see your web browser automatically open up a specific page on the iOS app.

## Voila! You're done.
