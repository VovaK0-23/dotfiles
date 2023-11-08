# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess

from typing import Dict, Union
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal, send_notification

mod = "mod4"
terminal = guess_terminal()
home = os.path.expanduser("~")
scripts_path = home + "/.config/qtile/scripts/"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod, "shift"], "Tab", lazy.next_screen()),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Flip layout for MONADTALL/MONADWIDE
    Key([mod, "shift"], "f", lazy.layout.flip(), desc="Flip layout"),
    # Grow window.
    Key([mod, "control"], "k", lazy.layout.grow(), desc="Increase current"),
    Key([mod, "control"], "j", lazy.layout.shrink(), desc="Decrease current"),
    # Toggle between different layouts as defined below
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "Return", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "shift"], "r", lazy.reboot(), desc="Reboot Qtile"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod], "n", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    # Spawn
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "w", lazy.spawn("rofi -show window")),
    Key([mod], "e", lazy.spawn("emacsclient -c")),
    Key([mod], "p", lazy.spawn("pamac-manager")),
    Key([mod], "d", lazy.spawn('rofi -show combi')),
    Key([mod], "f", lazy.spawn("thunar")),
    Key([mod], "b", lazy.spawn("chromium")),
    Key([mod, "shift"], 'v', lazy.spawn("bash " + scripts_path + "xrandr_setup.sh -v")),
    Key([mod, "shift"], 'b', lazy.spawn("bash " + scripts_path + "xrandr_setup.sh -h")),

    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),

    Key([mod], "Print", lazy.spawn("shutter -c")),
    Key([], "Print", lazy.spawn("shutter -c -s")),
]


group_labels = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "󰙯",
    "",
]

groups = [Group(name=i, label=group_labels[int(i) - 1]) for i in "1234567890"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

# Colors are from Tomorrow Night or Materia Red colorsheme (aur pkg materia-custom-accent-git)
colors: Dict[str, Dict[str, str]] = {
    # Normal colors
    "normal": {
        "bg": '#1d1f21',
        "fg": '#c5c8c6',
        "red":     '#cc6666',
        "green":   '#b5bd68',
        "yellow":  '#e6c547',
        "blue":    '#81a2be',
        "magenta": '#b294bb',
        "cyan":    '#70c0ba',
        "white":   '#373b41',
    },
    # Bright colors
    "bright": {
        "black":   '#666666', # bright black is grey
        "red":     '#ff3334',
        "green":   '#9ec400',
        "yellow":  '#f0c674',
        "magenta": '#b77ee0',
        "cyan":    '#54ced6',
        "white":   '#282a2e',
    }
}

layouts = [
    layout.MonadTall(
        margin=5, border_width=4,
        border_focus=colors["normal"]["red"],
        border_normal=colors["bright"]["black"],
        single_border_width= 0, ratio=0.75
    ),
    layout.MonadWide(
        margin=5, border_width=4,
        border_focus=colors["normal"]["red"],
        border_normal=colors["bright"]["black"],
        single_border_width= 0, ratio=0.75
    ),
    layout.Max(),
    layout.TreeTab(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Source Code Pro",
    fontsize=12,
    padding=2,
    foreground=colors["normal"]["fg"],
    background=colors["normal"]["bg"]
)

extension_defaults = widget_defaults.copy()

def init_widgets(right=True):
    base_widgets = [
        widget.GroupBox(
            fontsize=16,
            disable_drag=True,
            highlight_method="text",
            urgent_alert_method="text",
            this_current_screen_border=colors["normal"]["red"],
            active=colors["normal"]["blue"],
            inactive=colors["bright"]["black"],
            urgent_text=colors["normal"]["yellow"]
        ),
        widget.Sep(linewidth=1, padding=15),
        widget.CurrentLayout(font="Noto Sans Bold"),
        widget.Sep(linewidth=1, padding=15),
        widget.WindowName(font="Noto Sans"),
    ]

    all_widgets = base_widgets + [
        widget.Sep(linewidth=1, padding=15),
        widget.TextBox(
            text=" ",
            padding=0,
            fontsize=16,
            foreground=colors["normal"]["blue"]
        ),
        widget.Clock(
            font="Noto Sans",
            format="%Y-%m-%d %H:%M",
        ),
        widget.Sep(linewidth=1, padding=15),
        widget.TextBox(
            text="󰕾 ",
            padding=0,
            fontsize=16,
            foreground=colors["normal"]["blue"]
        ),
        widget.PulseVolume(limit_max_volume=True, font="Noto Sans", width=35),
        widget.Sep(linewidth=1, padding=15),
        widget.TextBox(
            name="layout",
            font="Noto Sans Bold",
            fontsize=14,
            foreground=colors["normal"]["red"],
            text="us"
        ),
        # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
        # widget.StatusNotifier(),
        widget.Systray(),
        widget.Sep(linewidth=1, padding=15),
        widget.QuickExit(default_text='⏻', countdown_format='{}', padding=5, foreground=colors["normal"]["red"]),
        widget.Sep(linewidth=0, padding=10),
    ]
    if right:
        return all_widgets
    else:
        return base_widgets

screens = [
    Screen(top=bar.Bar(widgets=init_widgets(), size=26, opacity=0.8,
        # margin=[top,right,bottom,left]
        margin=[3,8,3,5]
    )),
    Screen(top=bar.Bar(widgets=init_widgets(right=False), size=26, opacity=0.8, margin=[3,8,3,5])),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

@hook.subscribe.startup_once
def startup_once():
    subprocess.call([scripts_path + "autostart.sh"])

@hook.subscribe.startup_complete
def startup_complete():
    subprocess.call([scripts_path + "xrandr_setup.sh", "-h"])
    subprocess.Popen(["nohup", scripts_path + "keyboard_layout.sh"])
    subprocess.Popen(["discord"])
    subprocess.Popen(["telegram-desktop"])
    subprocess.Popen(["chromium"])

# @hook.subscribe.startup
# def start_always():
#     Set the cursor to something sane in X
#     subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])

@hook.subscribe.client_new
def client_new(client):
    info = client.info()
    # send_notification("qtile", f"{info}")
    if 'chromium' in info['wm_class']:
        client.togroup("1")
    elif 'discord' in info['wm_class']:
        client.togroup("9")
    elif 'telegram-desktop' in info['wm_class']:
        client.togroup("0")

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="confirm"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="file_progress"),
        Match(wm_class="notification"),
        Match(wm_class="splash"),
        Match(wm_class="toolbar"),
        Match(wm_class="Arandr"),
        Match(wm_class="feh"),
        Match(wm_class="shutter"),
    ],
    border_width=0,
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
