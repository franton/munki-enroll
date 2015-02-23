#!/bin/sh 

# Script to enroll a computer to munki as part of a DeployStudio workflow.

# Author  : Richard Purves <contact@richard-purves.com>
# Version : 1.0 - 21-02-2015 - Initial Version (based on https://github.com/flammable/munki-enroll)
#         : This version has been modified to pass a custom catalog and manifest name to the php script.
#         : Easier to mod this script than the php script after the fact.
# Version : 1.1 - 22-02-2015 - Added the rest of our desired munki client configuration and bootstrapping.
#         : Also removed all the quotes characters as DeployStudio STILL hasn't fixed their issue where it turns
#         : " into "\u201C" and/or "\u201D" for left or right hand quotes respectively.

# Set up variables here

SUBMITURL=http://munki/repo/munki-enroll/enroll.php
REPO=http://munki/repo
CATALOG=production
MANIFEST=everyone

# Get munki_enroll to see if there's an existing manifest for this computer hostname.
# Create it, if it doesn't exist and attach it to the manifest name in the variable with the production catalog.

/usr/bin/curl --max-time 5 --silent --get -d hostname=$DS_HOSTNAME -d catalog=$CATALOG -d manifest=$MANIFEST $SUBMITURL

# Ok, now we need to configure and bootstrap the rest of munki on the target computer.

# First off, define the manifest the computer should use based on the handy DeployStudio environment variable
/usr/bin/defaults write /Library/Preferences/ManagedInstalls ClientIdentifier $DS_HOSTNAME

# This defines the repo that Munki will use
/usr/bin/defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL $REPO

# Install Apple Updates as part of the update process
/usr/bin/defaults write /Library/Preferences/ManagedInstalls InstallAppleSoftwareUpdates True

# Days Between Notifications - currently once a day.
/usr/bin/defaults write /Library/Preferences/ManagedInstalls DaysBetweenNotifications -int 1

# Suppress User Notifications
/usr/bin/defaults write /Library/Preferences/ManagedInstalls SuppressUserNotifications True

# Munki will automatically install updates it finds if at the login window.
/usr/bin/defaults write /Library/Preferences/ManagedInstalls SuppressAutoInstall False

# Enforce updates on logout ONLY.
/usr/bin/defaults write /Library/Preferences/ManagedInstalls InstallRequiresLogout True

# Now we need munki to install everything at first boot.
/usr/bin/touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup

# All done!

exit 0
