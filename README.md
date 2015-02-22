# Munki Enroll

A set of scripts to automatically enroll clients in Munki. Original by [edingc/munki-enroll](https://github.com/edingc/munki-enroll). This fork is forked from [flammable/munki-enroll](https://github.com/flammable/munki-enroll) and credit is due here.

## Why modify Munki Enroll?

We're using Munki to bootstrap Macs after imaging with DeployStudio. However, we prefer not to set the [ClientIdentifier or SoftwareRepoURL](https://code.google.com/p/munki/wiki/configuration) - the repository is located at http://server/munki_repo, and we create a unique manifest per machine. Each manifest is named after the hostname of the computer, and will eventually include other manifests, depending on the software that should be made available to the computer.

While I don't mind creating manifests manually each time I need to image a new Mac, this is not convenient nor possible for everyone that has access to use our DeployStudio server. Without a manifest, though, each new Mac receives no software.

This fork of Cody Eding's Munki Enroll project is simpler, and should fit the needs of the client i'm working for.

Here's how it works:

1. Someone with the proper permissions to use the DeployStudio server runs the imaging workflow.
2. DeployStudio prompts the user for the hostname of the computer, then writes a basic OS X image to the hard drive.  After the imaging is completed, DeployStudio reboots and runs the post-imaging tasks. This process writes the desired munki behaviour preferences, the munki tools package and enrolls the computer into munki reports.
3. If the hostname already exists as a manifest, the script exits. Otherwise, the server creates a new basic manifest based on the hostname of the computer.
4. This manifest will then link to the top level "everyone" manifest for a basic software loadout. Further customisation is then performed later by the appropriate admin user.

If a user needs more software pushed to their computer, we edit their computer manifest.

### More?

You should check out [edingc/munki-enroll](https://github.com/edingc/munki-enroll) for the original intentions behind his code, and for installation instructions.

## License

Munki Enroll, like the contained CFPropertyList project, is published under the [MIT License](http://www.opensource.org/licenses/mit-license.php).
