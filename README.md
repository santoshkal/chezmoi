# My Dotfiles — machine-specific configuration managed by Chezmoi

Install with:

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/santoshkal/chezmoi/main/install.sh)"
```

---

# Fedora 44 + Hyprland (UWSM) + NVIDIA — Setup & Post-Install Checks

This guide covers installing Fedora 44 Everything in TTY mode, applying these
dotfiles via chezmoi, and verifying the Hyprland + NVIDIA hybrid graphics
stack afterwards.

## 1. Installation (Fedora 44 Everything → TTY)

1. Download the **Fedora Everything 44** ISO: https://fedoraproject.org/misc/
2. Boot the ISO and start the install.
3. In **Software Selection**, pick **Minimal Install** (no desktop environment).
4. Complete partitioning (enable LUKS encryption on a laptop), network, and
   create your user with admin/sudo rights.
5. Reboot into a bare TTY, then install git and apply these dotfiles:

   ```bash
   sudo dnf install -y git
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/santoshkal/chezmoi/main/install.sh)"
   ```

6. The chezmoi scripts install packages (see `.chezmoiscripts/`) including
   `hyprland` from the official Fedora repos — no COPR needed on F44.

## 2. BIOS / Graphics

- Set BIOS to **Hybrid Graphics** (Intel iGPU + NVIDIA dGPU).
- **Secure Boot**: either disable it, or keep it enabled and enroll a MOK key
  before installing `akmod-nvidia-580xx` (see https://rpmfusion.org/Howto/NVIDIA).
- The NVIDIA setup script runs automatically on laptops
  (`run_once_after_40-configure-nvidia.sh.tmpl`, gated on `chassisType=notebook`).

### NVIDIA driver branch — IMPORTANT for the P1000

The Quadro P1000 is a **Pascal** GPU. Fedora 44 ships the **595.x** driver by
default, which **dropped support for Maxwell/Pascal/Volta GPUs**. The install
script detects the chipset and uses the **legacy `akmod-nvidia-580xx`** branch
instead, and pins the packages with `dnf mark user` so dnf can't swap back to
595 on update.

The 580xx packages are only in the full `rpmfusion-nonfree` repo (not
`rpmfusion-nonfree-nvidia-driver`), which the `10-packages` script enables.

## 3. Post-Installation Checks

Run these in order to verify everything works.

### 3.1 NVIDIA driver

```bash
nvidia-smi                # shows GPU + driver version (expect 580.xxx)
lspci | grep -i nvidia    # GPU detected
cat /sys/module/nvidia_drm/parameters/modeset   # must print Y

# Confirm you are on the legacy 580xx branch, NOT the 595 driver:
dnf list installed 'akmod-nvidia*'
dnf versionlock list 2>/dev/null || dnf mark user    # 580xx should be pinned
```

If `nvidia-smi` shows a 595.x driver, the module is wrong for a Pascal GPU —
reinstall with `sudo dnf install akmod-nvidia-580xx xorg-x11-drv-nvidia-580xx-cuda`.

### 3.2 Secure Boot / MOK

```bash
mokutil --sb-state        # Enabled → enroll key (see step 2)
lsmod | grep nvidia_drm   # module loaded after reboot
```

### 3.3 Systemd user services (UWSM)

```bash
systemctl --user status waybar dunst hyprpaper hypridle
```

All should be `active (running)`. Also verify:

```bash
systemctl --user status hyprpolkitagent   # polkit for GUI auth prompts
```

### 3.4 Hyprland session

- Log into a TTY and start the session (UWSM):
  ```bash
  uwsm start hyprland
  ```
- Inside the session check Wayland is used:
  ```bash
  echo $XDG_SESSION_TYPE        # wayland
  hyprctl monitors              # lists your display(s)
  ```

### 3.5 Waybar / notifications

```bash
pgrep -x waybar                # bar is running
dunstctl is-paused             # should print "false"
dunstctl count                 # notification queue
```

### 3.6 NVIDIA env vars (UWSM)

```bash
cat ~/.config/uwsm/env-hyprland    # contains LIBVA_DRIVER_NAME / __GLX_VENDOR_LIBRARY_NAME
```

### 3.7 GPU switching (hybrid / PRIME)

```bash
glxinfo | grep "OpenGL renderer"    # per-app: __NV_PRIME_RENDER_OFFLOAD=1
prime-run <app>                     # run an app on the dGPU
```

### 3.8 Suspend / resume

```bash
systemctl --user status nvidia-suspend nvidia-resume   # enabled on laptops
```

### 3.9 Audio

```bash
pactl info 2>/dev/null | grep "Server Name" || wpctl status
```

## 4. Troubleshooting quick links

- Hyprland NVIDIA wiki: https://wiki.hypr.land/Nvidia/
- RPM Fusion NVIDIA howto: https://rpmfusion.org/Howto/NVIDIA
- Check logs: `journalctl --user -u waybar -n 50`, `hyprland log` inside session
