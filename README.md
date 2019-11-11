# homeautomation
My config files for openhab2 and pilight

## Bindings required
go to the Paper UI and add the following bindings
* Exec Binding (execute the pilight commands)
* Astro Binding (get the sunrise/ sunset times)
* Amaon Echon Control Binding (allow to control everything via Echo)
* Misc - openHAB Cloud Connector (for alexa control)
    * create an account on [myopenhub.org](https://myopenhab.org/)

## Install pilight
* first we must get the [wiringpi]() IO setup:
  ```bash
  sudo apt-get install wiringpi
  # make a test if it's working
  gpio readall
  ```
* then we install [pilight]():
  ```bash
  # add the source to apt
  sudo tee -a /etc/apt/sources.list <<< "deb http://apt.pilight.org/ stable main"

  # add the signed key
  wget -O - http://apt.pilight.org/pilight.key | sudo apt-key add -

  # update apt-cache
  sudo apt-get update

  # check available version
  sudo apt-cache madison pilight

  # chose one and install it (at the time of this document, 8.1.5 was the latest stable)
  sudo apt-get install pilight=8.1.5
  ```
    * troubleshooting: if apt complains about `libmbedcrypto0` and `libmbedtls10` (not available for the raspian i've used), I've simply added the source-tree of the previous release and triggered the install again
    ```bash
    sudo tee -a /etc/apt/sources.list <<< "deb http://raspbian.raspberrypi.org/raspbian/ stretch main contrib non-free rpi"
    sudo apt-get update
    sudo apt-get install pilight=8.1.5
    ```
* download and update the pilight configuration (using my configuration)
  ```bash
  # get the configuration from my github
  sudo wget https://raw.githubusercontent.com/mitschen/homeautomation/master/pilight/config.json -O /etc/pilight/config.json

  # get the systemfile from my github
  sudo wget https://raw.githubusercontent.com/mitschen/homeautomation/master/pilight/pilight.service -O /etc/systemd/system/pilight.service

  # enable pilight for autostart
  sudo systemctl enable pilight

  # guarantee that we won't run into the "no pilight- ssdp connection found" issue
  sudo systemctl enable systemd-networkd-wait-online.service
  ```
## Configure openhab2
* download and setup items, rules and things. **CAUTION:** these commands will overwrite the defaults.
  ```bash
   # items
  sudo wget https://raw.githubusercontent.com/mitschen/homeautomation/master/openhab2/items/default.items -O /etc/openhab2/items/default.items
   # rules
  sudo wget https://raw.githubusercontent.com/mitschen/homeautomation/master/openhab2/rules/default.rules -O /etc/openhab2/rules/default.rules
   # things
  sudo wget https://raw.githubusercontent.com/mitschen/homeautomation/master/openhab2/things/default.things -O /etc/openhab2/things/default.things
  ```
* make sure, that the `openHAB Cloud Connector` is installed via Paper UI.
    * get the UUID from your pi: `cat /var/lib/openhab2/uuid`
    * get the secret for your pi: `cat /var/lib/openhab2/openhabcloud/secret`
    * enter your [openhab account](https://myopenhab.org/account) and add the credentials
* now you should be able to find the devices via Alexa App
## TODO
* List the bindings needed for openhab2
* List the functionality achieved
* don't forget to give habian user the sudo rights, following the [link](https://community.openhab.org/t/openhab-sudo-exec-binding/34988). In principle open sudoers config `sudo visudo -f /etc/sudoers.d/010_pi-nopasswd` and add the following line `openhab ALL=(ALL) NOPASSWD: ALL`. This is necessary, because i'm restarting pilight-daemon with almost each command. I didn't find a solution for the issue `NOTICE: no pilight ssdp connections found` so far.


## References
* openhab and alexa found [here](https://www.meintechblog.de/2017/08/openhab-fuer-beginner-einrichtung-mit-alexa-sprachsteuerung-in-unter-einer-stunde/)
