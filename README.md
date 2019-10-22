# homeautomation
My config files for openhab2 and pilight

## TODO
* List the bindings needed for openhab2
* List the functionality achieved
* don't forget to give habian user the sudo rights, following the [link](https://community.openhab.org/t/openhab-sudo-exec-binding/34988). In principle open sudoers config `sudo visudo -f /etc/sudoers.d/010_pi-nopasswd` and add the following line `openhab ALL=(ALL) NOPASSWD: ALL`. This is necessary, because i'm restarting pilight-daemon with almost each command. I didn't find a solution for the issue `NOTICE: no pilight ssdp connections found` so far.
