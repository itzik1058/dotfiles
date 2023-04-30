#!/usr/bin/env python3

from json import dumps
from subprocess import run
from typing import Any

# dbus-python
from dbus import SystemBus
from dbus.mainloop.glib import DBusGMainLoop

# python-gobject
from gi.repository import GLib

header = ["device", "type", "state", "connection"]
icon = {
    "ethernet": "󰈁",
    "wifi": "󰖩",
    "gsm": "󰣺",
}


def format_networks() -> dict[str, str]:
    sp = run(["nmcli", "-t", "device"], capture_output=True)
    sp.check_returncode()
    connections = [
        dict(zip(header, connection.split(":")))
        for connection in sp.stdout.decode().splitlines()
    ]
    networks = {}
    for c in connections:
        if c["state"] != "connected":
            continue
        networks[c["type"]] = {
            "connection": c["connection"],
            "device": c["device"],
            "icon": icon[c["type"]],
        }
    return networks


def on_event(name: Any, properties: Any, _: Any) -> None:
    if "Ip4Connectivity" not in properties:
        return
    print(dumps(format_networks()))


if __name__ == "__main__":
    DBusGMainLoop(set_as_default=True)

    SystemBus().add_signal_receiver(
        handler_function=on_event,
        signal_name="PropertiesChanged",
        dbus_interface="org.freedesktop.DBus.Properties",
        bus_name="org.freedesktop.NetworkManager",
        arg0="org.freedesktop.NetworkManager.Device",
    )

    print(dumps(format_networks()))

    GLib.MainLoop().run()
