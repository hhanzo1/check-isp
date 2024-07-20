# About
Check ISP network connectivity and send a notification on failure.
# Getting Started
## Prerequisites
* Unraid 6.12.10
* Uptime Kuma

A remote instance of Uptime Kuma is required in order to receive notifications when monitoring your home internet connectivity.

In Uptime Kuma create a Push Monitor and note the Push URL.

I host this script on Unraid since it's on 24/7 but the script could be run on another device.
For example, pfsense or any other host on your home network which is constantly powered on.
## Installation
In the Unraid web interface, access Settings\\UserScripts:

- Add a New Script, give it a name like check-isp
- Edit the script
- Copy & Paste the contents of the script from [here.](https://github.com/hhanzo1/check-vpn-tunnel/blob/main/check-isp.sh).
- Add a cron schedule

```bash
https://github.com/hhanzo1/check-vpn-tunnel/blob/main/check-isp.sh
```

- Update the script's BASE_URL with the Uptime Kuma Push URL.
- Check if the scripts LOG path location is correct.

# Usage
Test the script is running as expected by running manually, then scheduled via cron.
## Enable the check script
```bash
# Run every minute
* * * * * /home/[USERID]/check-isp.sh
```
If the Push URL does not receive a HTTP request within Heart Beat internal (default 60 seconds), an alert will be triggered.

## View Badges
Status and Uptime [Uptime Kuma Badges](https://github.com/louislam/uptime-kuma/wiki/Badge) can be configured.

![isp status](https://uptime.netwrk8.com/api/badge/1/status)
![isp uptime](https://uptime.netwrk8.com/api/badge/1/uptime)
![isp uptime 30d](https://uptime.netwrk8.com/api/badge/1/uptime/720?label=Uptime(30d)&labelSuffix=d)

# Acknowledgments
* [Unraid](https://unraid.net/)
* [Uptime Kuma](https://github.com/louislam/uptime-kuma)
