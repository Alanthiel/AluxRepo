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
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import re
import socket
import subprocess

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


mod = "mod4"
terminal = guess_terminal()

mod = "mod4"                                     # Sets mod key to SUPER/WINDOWS
myTerm = "alacritty"                             # My terminal of choice

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down(),                      desc="Move focus down in stack pane"),    
    Key([mod], "j", lazy.layout.up(),                        desc="Move focus up in stack pane"),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down(),   desc="Move window down in current stack "),
    Key([mod, "control"], "j", lazy.layout.shuffle_up(),     desc="Move window up in current stack "),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next(),                  desc="Switch window focus to other pane(s) of stack"),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate,          desc="Swap panes of split stack"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal),                desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(),                     desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(),                       desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(),                desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(),               desc="Shutdown qtile"),
    Key([mod], "r", lazy.spawncmd(),                          desc="Spawn a command using a prompt widget"),

    # Personal KeyBindings
    Key([mod, "control"], 'w', lazy.spawn('env XSECURELOCK_PASSWORD_PROMPT=asterisks xsecurelock')),
    Key([mod, "control"], 'bracketleft', lazy.spawn('xinput reattach 16 2')),
    Key([mod, "control"], 'bracketright', lazy.spawn('xinput float 16')),
    Key([mod, "control"], "Return", lazy.spawn("bash /home/alux/.config/qtile/rofi-apps"),desc='Rofi Run Launcher'),
    Key([mod, "control"], 'x', lazy.hide_show_bar("bottom")),
    Key([mod, "shift"], "KP_Add", lazy.spawn("amixer -c 0 -q set Master 1dB+")),
    Key([mod, "shift"], "KP_Subtract", lazy.spawn("amixer -c 0 -q set Master 1dB-")),
    Key([], "Print", lazy.spawn("gnome-screenshot")),
]

groups = [Group(i) for i in "1234"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

layout_theme = {"border_width": 2,
                "margin": 3,
                "border_focus": "55eedd",
                "border_normal": "30004a"
                }

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2,margin=2, border_width=1, border_focus="55eedd",border_normal= "30004a" ),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Tile(shift_windows=True, **layout_theme),
    layout.Floating(**layout_theme)
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

colors = [["#0C0D12", "#0C0D12"], # panel background
          ["#434758", "#434758"], # background for current screen tab
          ["#ffffff", "#ffffff"], # font color for group names
          ["#ff5555", "#ff5555"], # border line color for current tab
          ["#1C1321", "#1C1321"], # border line color for other tab and odd widgets
          ["#271C0D", "#271C0D"], # color for the even widgets
          ["#e1acff", "#e1acff"]] # window name '''

prompt = "run:"
widget_defaults = dict(
    font="Mononoki Nerd Font",
    fontsize = 11,
    padding = 2,
    background=colors[2]
)
extension_defaults = widget_defaults.copy()

widgets_list = [
            widget.Sep(
                    linewidth = 0,
                    padding = 6,
                    foreground = colors[2],
                    background = colors[0]
                    ),
            widget.Image(
                    filename = "~/.config/qtile/icons/ico.png",
                    padding = 6,
                    mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn('bash /home/alux/.config/qtile/rofi-apps')}
                    ),
            widget.GroupBox(
                    font = "Ubuntu Bold",
                    fontsize = 9,
                    margin_y = 3,
                    margin_x = 0,
                    padding_y = 5,
                    padding_x = 3,
                    borderwidth = 3,
                    active = colors[2],
                    inactive = colors[2],
                    rounded = False,
                    highlight_color = colors[1],
                    highlight_method = "line",
                    this_current_screen_border = colors[3],
                    this_screen_border = colors [4],
                    other_current_screen_border = colors[0],
                    other_screen_border = colors[0],
                    foreground = colors[2],
                    background = colors[0]
                    ),
            widget.Prompt(
                    prompt = prompt,
                    font = "Ubuntu Mono",
                    padding = 10,
                    foreground = colors[3],
                    background = colors[1]
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 40,
                    foreground = colors[2],
                    background = colors[0]
                    ),
            widget.WindowName(
                    foreground = colors[6],
                    background = colors[0],
                    padding = 0
                    ),

            widget.ThermalSensor(
                    foreground = colors[2],
                    background = colors[4],
                    threshold = 90,
                    padding = 5
                    ),
            widget.TextBox(
                    text = " ⟳",
                    padding = 2,
                    foreground = colors[2],
                    background = colors[5],
                    fontsize = 14
                    ),
            widget.Pacman(
                    update_interval = 1800,
                    foreground = colors[2],
                    mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e sudo pacman -Syyu')},
                    background = colors[5]
                    ),
            widget.TextBox(
                    text = " Vol:",
                    mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn('amixer -c 0 -q set Master toggle')},
                    padding = 2,
                    foreground = colors[2],
                    background = colors[4],
                    fontsize = 11
                    ),
            widget.Volume(
                    padding = 5,
                    mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn('amixer -c 0 -q set Master toggle')},
                    foreground = colors[2],
                    background = colors[4]
                    ),
            widget.Memory(
                    foreground = colors[2],
                    background = colors[5],
                    mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e htop')},
                    padding = 5
                    ),
            widget.Net(
                    interface = "wlo1",
                    format = '{down} ↓↑ {up}',
                    foreground = colors[2],
                    background = colors[4],
                    mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e gnome-system-monitor')},
                    padding = 5
                    ),
            widget.TextBox(
                    text = " Battery:",
                    foreground = colors[2],
                    background = colors[5],
                    padding = 0
                    ),
            widget.Battery(
                    foreground = colors[2],
                    background = colors[5],
                    padding = 5
                    ),
            widget.CurrentLayoutIcon(
                    custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                    foreground = colors[0],
                    background = colors[4],
                    padding = 0,
                    scale = 0.5
                    ),
            widget.CurrentLayout(
                    foreground = colors[2],
                    background = colors[4],
                    padding = 5
                    ),

            widget.Clock(
                    foreground = colors[2],
                    background = colors[5],
                    format = "%A, %B %d  [ %H:%M ]"
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 10,
                    foreground = colors[0],
                    background = colors[5]
                    ),
            widget.Systray(
                    background = colors[0],
                    padding = 5
                    ),
            ]

screens = [
    Screen(
        bottom=bar.Bar(widgets=widgets_list, opacity=0.9, size=30),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

#@hook.subscribe.startup_once
#def start_once():
#    home = os.path.expanduser('~')
#    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])

@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'dialog'
    transient = window.window.get_wm_transient_for()
    if dialog or transient:
        window.floating = True
        
