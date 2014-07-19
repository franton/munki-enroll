# Munki Enroll

A set of scripts to automatically enroll clients in Munki. Adapted from [edingc/munki-enroll](https://github.com/edingc/munki-enroll).

## Why modify Munki Enroll?

We're using Munki to bootstrap Macs after imaging with DeployStudio.  However, we prefer not to set the [ClientIdentifier or SoftwareRepoURL](https://code.google.com/p/munki/wiki/configuration) - the repository is located at http://munki/repo, and we create a unique manifest per machine. Each manifest is named after the hostname of the computer, and includes other manifests, depending on the software that should be made available to the computer.

While I don't mind creating manifests manually each time I need to image a new Mac, this is not convenient nor possible for everyone that has access to use our DeployStudio server. Without a manifest, though, each new Mac receives no software.

This fork of Cody Eding's Munki Enroll project is considerably simpler, and fits our needs exactly.  Here's how it works:

1. Someone with the proper Active Directory permissions to use our DeployStudio server runs the faculty/staff imaging workflow.
2. DeployStudio prompts the user for the hostname of the computer, then writes a basic OS X image to the hard drive.  After the imaging is completed, DeployStudio reboots and runs the post-imaging tasks. The munki_enroll.sh script runs after the machine is bound to AD, but before the [bootstrap file](https://code.google.com/p/munki/wiki/BootstrappingWithMunki) is created.
3. If the hostname already exists as a manifest, the script exits. Otherwise, the server creates a new basic faculty/staff manifest based on the hostname of the computer.

In our case, the new manifest contains two other manifests: "\_\__core_software" and "__faculty_staff".  The "core software" manifest contains software made available to everyone, but "faculty/staff" contains software just for faculty and staff (not labs, podiums, or servers).

If a user needs more software pushed to their computer, it's very easy for us to do so by editing their manifest.

### More?

You should check out [edingc/munki-enroll](https://github.com/edingc/munki-enroll) for the original intentions behind his code, and for installation instructions.

## License

Munki Enroll, like the contained CFPropertyList project, is published under the [MIT License](http://www.opensource.org/licenses/mit-license.php).
