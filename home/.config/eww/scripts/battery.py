#!/usr/bin/env python3

from json import dumps
from pathlib import Path
from subprocess import PIPE, Popen
from typing import Any

path_battery = next(Path("/sys/class/power_supply").glob("BAT*"))
icon = {
    "battery": ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"],
    "battery-charing": ["󰂎", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"],
}


def format_battery(status: str, capacity: int) -> dict[str, Any]:
    charge_level = capacity // 10
    if status in ("Charging", "Not charging"):
        # Not charging is still connected (and not discharging)
        icon_battery = icon["battery-charing"][charge_level]
    else:
        icon_battery = icon["battery"][charge_level]
    return {"capacity": capacity, "icon": icon_battery}


def print_battery() -> None:
    with open(path_battery / "status") as f:
        status = f.read().strip()
    with open(path_battery / "capacity") as f:
        capacity = int(f.read())
    print(dumps(format_battery(status, capacity)))


if __name__ == "__main__":
    print_battery()
    with Popen("acpi_listen", stdout=PIPE) as p:
        for line in p.stdout:
            if line.decode().startswith("battery"):
                print_battery()
