#!/usr/bin/env python3

# TODO airplane mode

from argparse import ArgumentParser
from json import dumps
from subprocess import run

header = ["device", "type", "state", "connection"]
icon_network = {
    "ethernet": "󰈁",
    "wifi": "󰖩",
    "gsm": "󰣺",
}

if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "-t",
        type=str,
        choices=icon_network,
        help="device type",
        dest="type",
    )
    args = parser.parse_args()

    sp = run(["nmcli", "-t", "device"], capture_output=True)
    if sp.returncode:
        exit(sp.returncode)
    connections = [
        dict(zip(header, connection.split(":")))
        for connection in sp.stdout.decode().splitlines()
    ]
    networks = {}
    for c in connections:
        if c["state"] != "connected":
            continue
        if c["type"] not in icon_network:
            continue
        networks[c["type"]] = {
            "connection": c["connection"],
            "device": c["device"],
            "icon": icon_network[c["type"]],
        }
        if c["type"] == args.type:
            print(icon_network[args.type], c["connection"])
            break
    if not args.type:
        print(dumps(networks))
