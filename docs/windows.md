## Usage on Windows

This flake can be used on Windows in a home-manager-only capacity for WSL.

### Preparation

1. Set up GPG and SSH on Windows:
    1. Install `gpg4win` with `winget`:
        ```
        winget install gpg4win
        ```
    2. In an elevated PowerShell window, start the agents:
        ```powershell
        Set-Service ssh-agent -StartupType automatic
        Start-Service ssh-agent

        Register-ScheduledJob -Name GPGAgent -Trigger (New-JobTrigger -AtLogOn) -RunNow -ScriptBlock {
            & "${env:ProgramFiles(x86)}/GnuPG/bin/gpg-connect-agent.exe" /bye
        }
        ```
    3. Add the following to `%APPDATA%\Roaming\.gnupg\gpg-agent.conf`:
        ```
        enable-putty-support
        ```
    4. Add the following to `%APPDATA%\Roaming\.gnupg\scdaemon.conf`:
        ```
        card-timeout 1
        disable-ccid
        reader-port Yubico YubiKey
        ```
    5. Restart the agent:
        ```
        gpg-connect-agent killagent /bye
        gpg-connect-agent /bye
        ```
    6. Ensure card can now be read with `gpg --card-status`
2. Set up GPG and SSH on WSL:
    1. Install packages:
        ```bash
        sudo apt-get update && apt-get -y upgrade
        sudo apt-get -y install socat iproute2 gnupg2
        ```
    2. Download the pageant shim:
        ```bash
        destination="$HOME/.ssh/wsl2-ssh-pageant.exe"
        mkdir -p "$destination"
        wget -O "$destination" "https://github.com/BlackReloaded/wsl2-ssh-pageant/releases/latest/download/wsl2-ssh-pageant.exe"
        chmod +x "$destination"
        ```
    3. Add the shim autostart to `~/.bashrc`:
        ```bash
        export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
        if ! ss -a | grep -q "$SSH_AUTH_SOCK"; then
        rm -f "$SSH_AUTH_SOCK"
        wsl2_ssh_pageant_bin="$HOME/.ssh/wsl2-ssh-pageant.exe"
        if test -x "$wsl2_ssh_pageant_bin"; then
            (setsid nohup socat UNIX-LISTEN:"$SSH_AUTH_SOCK,fork" EXEC:"$wsl2_ssh_pageant_bin" >/dev/null 2>&1 &)
        else
            echo >&2 "WARNING: $wsl2_ssh_pageant_bin is not executable."
        fi
        unset wsl2_ssh_pageant_bin
        fi

        export GPG_AGENT_SOCK="$HOME/.gnupg/S.gpg-agent"
        if ! ss -a | grep -q "$GPG_AGENT_SOCK"; then
        rm -rf "$GPG_AGENT_SOCK"
        wsl2_ssh_pageant_bin="$HOME/.ssh/wsl2-ssh-pageant.exe"
        if test -x "$wsl2_ssh_pageant_bin"; then
            (setsid nohup socat UNIX-LISTEN:"$GPG_AGENT_SOCK,fork" EXEC:"$wsl2_ssh_pageant_bin --gpg S.gpg-agent" >/dev/null 2>&1 &)
        else
            echo >&2 "WARNING: $wsl2_ssh_pageant_bin is not executable."
        fi
        unset wsl2_ssh_pageant_bin
        fi
        ```
    4. Restart your session and confirm you can now run GPG and SSH commands
4. Install dependencies:
    ```bash
    sudo apt-get -y install git-crypt

    # Latest version of Nix Unstable from https://github.com/numtide/nix-unstable-installer/releases
    sh <(curl -L https://github.com/numtide/nix-flakes-installer/releases/download/nix-2.4pre20210604_8e6ee1b/install)
    ```
5. Set up environment:
    ```bash
    sudo apt-get -y install fish
    chsh -s /usr/bin/fish

    echo -e '\n. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"' >> ~/.profile
    ```
5. Clone the repo:
    ```bash
    git clone git@github.com:CitadelCore/nixflk.git && cd nixflk
    git-crypt unlock

    nix --experimental-features "nix-command flakes" flake metadata
    ```
