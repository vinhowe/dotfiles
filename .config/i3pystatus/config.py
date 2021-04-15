from i3pystatus import Status
import pomodoro

status = Status()

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
status.register(
    "clock",
    format="🕒 %a %-d %b %H:%M:%S",
)

status.register(
    pomodoro.MpvPomodoro(inactive_format="start pomodoro", sound="/usr/share/sounds/freedesktop/stereo/complete.oga"),
)

# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register(
    "pulseaudio",
    format="🔉 {volume:03.0f}",
)

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load", format="📈 1m: {avg1} 5m: {avg5}")

# Shows your CPU temperature, if you have a Intel CPU
status.register(
    "temp",
    format="🌡️ {temp:.0f}°C",
)

# Shows memory usage
status.register(
    "mem",
    format="📝 {percent_used_mem:.0f}%",
)

# Shows disk usage of /
# Format:
# 42/128G [86G]
status.register(
    "disk",
    path="/",
    format="💾 /: {avail:.2f}G",
)

# Shows the address and up/down state of eth0. If it is up the address is shown in
# green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
status.register(
    "network",
    interface="eno2",
    format_up="🔌 {v4cidr}",
    format_down="🔌 {interface} down",
)

# Note: requires both netifaces and basiciw (for essid and quality)
status.register(
    "network",
    interface="wlo1",
    format_up="📶 {essid} {quality:2.0f}% {v4}",
    format_down="📶 {interface} down",
)

status.register("now_playing", format="🎵 {title}")

status.run()
