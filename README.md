# Ara Manufacturing User
Repository to be used by manufacturer for simple setup

## Using This Repository
1. Clone repo to local machine folder
2. Run `make install`
3. When prompted, enter aws access key ID and secret access key
4. When prompted for region enter 'us-west-2', when prompted for output enter 'json'
5. After the installation step is complete, reboot the device using `sudo reboot`to continue.

## Script Entry Points
The following commands will display usage information for their respective scripts.
1. `manufacture-ara-devices -h`
2. `package-ara-devices -h`

## Help
2. `make install` - Download and install python3.8, virtualenv, wget, and unzip. Download nordic command line tools. Login in to aws codeartifact and install manufacturing scripts. Then unzip and install nrf-command-line-tools for programming via Jlink.
3. `make upgrade` - Upgrade ara-manufacturing package to latest version.

Or run `make help` to see these options