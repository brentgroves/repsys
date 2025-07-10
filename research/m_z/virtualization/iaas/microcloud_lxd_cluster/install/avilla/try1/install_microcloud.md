# **[How to install MicroCloud](<https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/install/#howto-install>)**

## Installation

To install MicroCloud, install all required snaps on all machines that you want to include in your cluster. You can optionally specify a channel for each snap, but generally, you can leave out the channel to use the current recommended default.

To do so, enter the following commands on all machines:

```bash
sudo snap install lxd --channel=5.21/stable --cohort="+"
snap install microceph --channel=squid/stable --cohort="+"
snap install microovn --channel=24.03/stable --cohort="+"
snap install microcloud --channel=2/stable --cohort="+"

sudo snap install lxd --cohort="+"
sudo snap install microceph --cohort="+"
sudo snap install microovn --cohort="+"
sudo snap install microcloud --cohort="+"
```

The --cohort flag ensures that versions remain **[synchronized during later updates](https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/update_upgrade/#howto-update-sync)**.

Following installation, make sure to **[hold updates](https://documentation.ubuntu.com/microcloud/latest/microcloud/how-to/update_upgrade/#howto-update-hold)**.

To indefinitely hold all updates to the snaps needed for MicroCloud, run:

`sudo snap refresh --hold lxd microceph microovn microcloud`

Then you can perform manual updates on a schedule that you control.

For detailed information about holds, see: Pause or stop automatic updates in the Snap documentation.
