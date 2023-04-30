#!/usr/bin/env python3

from argparse import ArgumentParser
from json import dumps
from pathlib import Path
from subprocess import run
from time import sleep
from typing import Any

# python-watchdog
from watchdog.events import FileModifiedEvent, FileSystemEventHandler
from watchdog.observers import Observer

path_backlight = Path("/sys/class/backlight")
icon_brightness = ["󰃚", "󰃛", "󰃜", "󰃝", "󰃞", "󰃟", "󰃠"]


def format_brightness(brightness: int, max_brightness: int) -> dict[str, Any]:
    brightness_pct = 100 * brightness // max_brightness
    icon = icon_brightness[brightness_pct * len(icon_brightness) // 101]
    return {"brightness": brightness_pct, "icon": icon}


def listen():
    backlight = next(path_backlight.iterdir())
    path_brightness = backlight / "brightness"
    path_max_brightness = backlight / "max_brightness"
    with path_max_brightness.open() as f:
        max_brightness = int(f.read())
    with path_brightness.open() as f:
        print(dumps(format_brightness(int(f.read()), max_brightness)))

    class EventHandler(FileSystemEventHandler):
        def on_modified(self, event: FileModifiedEvent):
            with open(event.src_path) as f:
                print(dumps(format_brightness(int(f.read()), max_brightness)))

    observer = Observer()
    observer.schedule(EventHandler(), path_brightness)
    observer.start()
    try:
        while observer.is_alive():
            sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()


if __name__ == "__main__":
    parser = ArgumentParser()
    subparsers = parser.add_subparsers(dest="command", required=True)
    subparsers.add_parser("listen")
    subparsers.add_parser("set").add_argument(
        "brightness", type=int, help="brightness percentage"
    )
    args = parser.parse_args()

    match args.command:
        case "set":
            run(["xbacklight", "-set", str(args.brightness)])
        case "listen":
            listen()
