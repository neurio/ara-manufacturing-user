# Ara Manufacturing User
Repository to be used by manufacturer for simple setup

## Using This Repository
1. Clone repo to local machine folder
2. When prompted, enter aws access key ID and secret access key
3. When prompted for region enter 'us-west-2', when prompted for output enter 'json' 
4. Run `make install`

## Help
1. `make setup` - Download and install python3.8, virtualenv, wget, and unzip. Download nordic command line tools. Login in to aws codeartifact and install manufacturing scripts.
2. `make install` - Unzip and install nrf-command-line-tools for programming via Jlink. 

Or run `make help` to see these options