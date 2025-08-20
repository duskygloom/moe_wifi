### MoE Wi-Fi
MoE Wi-Fi Utility Application

### Installation
**Android**
1. Download `app-release.apk` from the [Releases](https://github.com/duskygloom/moe_wifi/releases) page.
2. Install the application from the apk file.
3. Android may say that this app is harmful but its not 🥺🥺.

**Linux**
1. Download `linux-portable.tar.xz` from the [Releases](https://github.com/duskygloom/moe_wifi/releases) page.
2. Extract the tar file into the directory where you want the application to be.
3. Update the `Exec` and `Icon` path.
4. Move the desktop file into an application directory, e.g. `$HOME/.local/share/applications`.

### Features
1. Save accounts and use them to login with one click (or not because of some issues in Android, hopefully they will be fixed in a later update).
2. Check running sessions and kill them when needed.
3. Switch between manual and auto mode from the application itself in Linux. It uses `nmcli` and won't work without it.

### Issues
- **IP changes causing sessions to logout.**<br>
    1. systemd-resolved<br>
        If your system is using `systemd-resolved` along with `NetworkManager`, it may lead to this situation.<br>
        Disable `systemd-resolved` by using the following steps:
        ```sh
        sudo systemctl disable systemd-resolved
        sudo systemctl stop systemd-resolved
        sudo rm /etc/resolv.conf
        sudo vim /etc/NetworkManager/NetworkManager.conf
        ```
        Under the `[main]` section, add `dns=default`.
