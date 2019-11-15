# Setting up Cocoda development on Ubuntu

This guide summarizes steps to install all software used and [developed in project coli-conc](https://coli-conc.gbv.de/publications/software/) for development of Cocoda. Some steps may be omitted or modified if you know what you are doing.

If you just want to run an instance of Cocoda, this setup is not required! Just [download a release](https://github.com/gbv/cocoda/releases), make its content available via a web server and adjust the config file.

## VirtualBox

> skip this unless you want to set up the following steps in a VirtualBox VM

* Install Ubuntu 18.04 LTS
* Install software updates and restart
* Install VirtualBox Guest Additions and restart
* (if necessary) Go to Settings -> Devices -> Displays and increase resolution
* Settings -> Power -> Power Saving: Turn "Blank screen" to "Never"
* Open Terminal (ctrl+alt+t)

## Requirements

### Basic development tools

> required

~~~bash
sudo apt install -y git curl build-essential
~~~

### Node and nvm

> required but standard Node may be enough

The Node Version Manager (nvm) is useful to switch versions of NodeJS. See [nvm installation](https://github.com/nvm-sh/nvm/blob/master/README.md#installation-and-update) for background information.

~~~bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
source ~/.bashrc
nvm install stable
~~~

### jq

> only needed by selected parts but highly recommended anyway

~~~bash
sudo apt-get install -y jq
~~~

### MongoDB

> only needed by selected parts

There is a version of MongoDB provided by Ubuntu and a version provided by MongoDB. Better [install the latter](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/):

~~~bash
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod.service
sudo systemctl enable mongod.service
~~~

### Pandoc

> only needed to build manual

~~~bash
wget https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-1-amd64.deb
sudo dpkg --install pandoc*.deb
rm pandoc*.deb
~~~

If you also want to build user manual in PDF, the following are required (*not included in the VM to reduce disk space!*):

~~~bash
sudo apt-get install -y texlive-xetex texlive-fonts-recommended texlive-fonts-extra lmodern librsvg2-bin
~~~

## Development Environment

This is highly opiniated, every programmer has its own preferences.

### Chromium

> not required but recommended

~~~bash
sudo apt install -y chromium-browser
sudo update-alternatives --set x-www-browser /usr/bin/chromium-browser
~~~

### VSCodium

> not required

Go to <https://github.com/VSCodium/vscodium/releases>, download and install the latest `_amd64.deb` release:

~~~bash
wget <release-url>
sudo dpkg --install codium*.deb
rm codium*.deb
~~~

~~~bash
codium --install-extension octref.vetur
codium --install-extension buster.ndjson-colorizer
codium --install-extension dbaeumer.vscode-eslint
echo '{"editor.wordWrap":"on","editor.tabSize":2,"files.trimTrailingWhitespace":true,"files.insertFinalNewline":true,"files.trimFinalNewlines":true,"eslint.autoFixOnSave":true,"eslint.validate":["javascript",{"language":"vue","autoFix":true}]}' | jq . > ~/.config/VSCodium/User/settings.json
~~~

VSCodium can be started with `codium`.

## Cococda and coli-conc software stack

Assume everything will be in directory `~/coli-conc` (*not required*):

~~~bash
mkdir ~/coli-conc && cd coli-conc
~~~

### jskos-cli

~~~bash
npm i -g jskos-cli
~~~

### pm2

> only needed to enable Cocoda and/or jskos-server as permanent service

~~~bash
npm i -g pm2
pm2 startup
~~~

Run the command that is printed to enable pm2 process manager.

### Perl and skos2jskos

> only needed for selected parts of coli-conc software

~~~bash
sudo apt-get install -y cpanminus librdf-query-perl librdf-query-client-perl
cpanm --local-lib=~/perl5 local::lib
echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"' >> ~/.bashrc
source .bashrc
cpanm App::skos2jskos
~~~

### jskos-server

~~~bash
cd ~/coli-conc
git clone https://github.com/gbv/jskos-server.git
cd jskos-server
npm ci
~~~

Create a configuration

~~~bash
node -e 'let noAuth={auth:false,crossUser:true},config={};for(let type of ["mappings","annotations"]){config[type]={};for(let action of ["read","create","update","delete"]){config[type][action]=noAuth}};console.log(JSON.stringify(config))' | jq . > config/config.json
~~~

Start and enable as permanent service

~~~bash
pm2 start ecosystem.config.json
~~~

Check if jskos-server is running via `curl -s http://localhost:3000/status | jq .ok` (should return 1)

~~~bash
pm2 save
~~~

### Cocoda

~~~bash
cd ~/coli-conc
git clone https://github.com/gbv/cocoda.git
cd cocoda
npm ci
~~~

Create configuration and build distribution

~~~bash
node -e 'console.log(JSON.stringify({registries:[{provider:"MappingsApi",uri:"http://localhost:3000",status:"http://localhost:3000/status",autoRefresh:5000,subject:[{uri:"http://coli-conc.gbv.de/registry-group/existing-mappings"}],notation:["CT"],prefLabel:{en:"Concordance Registry (local)"}}]}))' | jq . > config/cocoda.json
~~~

Run during development

~~~bash
npm run serve
~~~

Cocoda should now be available at <http://localhost:8081/> and will be rebuild once you modify the source files (see `src/`).

Build distribution and enable as permament service

~~~
npm run build
echo '{"name":"cocoda","script":"http-server dist/"}' > ecosystem.config.json && pm2 start ecosystem.config.json && pm2 save
npm i -g http-server
pm2 start http-server --name "cocoda" -- dist/
pm2 save
~~~

Cocoda should now be available at <http://localhost:8080/>

Configuration of this instance can be modified in `dist/cocoda.json` but will be overwritten by `config/cocoda.json` on `npm run build`.

