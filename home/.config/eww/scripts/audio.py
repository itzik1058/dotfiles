#!/usr/bin/env python3

from argparse import ArgumentParser
from json import dumps
from subprocess import PIPE, Popen, run
from time import time
from typing import Any

icon_volume = ["󰕿", "󰖀", "󰕾"]
icon_volume_mute = "󰝟"
icon_microphone = "󰍬"
icon_microphone_mute = "󰍭"


def format_audio(device: str, device_type: str) -> dict[str, Any]:
    sp = run(["wpctl", "get-volume", device], capture_output=True)
    sp.check_returncode()
    status = sp.stdout.decode().strip()
    volume = int(float(status.split()[1]) * 100)
    mute = status.endswith("[MUTED]")
    volume_level = volume * len(icon_volume) // 101
    match device_type:
        case "source":
            icon_audio = icon_microphone_mute if mute else icon_microphone
        case "sink":
            icon_audio = icon_volume_mute if mute else icon_volume[volume_level]
        case _:
            raise KeyError()
    return {"volume": volume, "icon": icon_audio, "mute": mute}


def pactl_subscribe(device: str, device_type: str) -> None:
    print(dumps(format_audio(device, device_type)))
    last_call = time()
    with Popen(["pactl", "subscribe"], stdout=PIPE) as p:
        for line in p.stdout:
            event = line.decode().strip()
            match event.split():
                case ["Event", event_name, "on", event_device_type, _]:
                    if (
                        event_name.strip("'") == "change"
                        and event_device_type == device_type
                    ):
                        if time() - last_call > 0.01:
                            print(dumps(format_audio(device, device_type)))
                        last_call = time()


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("device", type=str, help="audio device")
    subparsers = parser.add_subparsers(dest="command", required=True)
    subparsers.add_parser("listen").add_argument(
        "type",
        type=str,
        choices=["sink", "source"],
        help="device type",
    )
    subparsers.add_parser("mute")
    subparsers.add_parser("set").add_argument(
        "volume",
        type=int,
        help="volume percentage",
    )
    args = parser.parse_args()

    match args.command:
        case "set":
            run(["wpctl", "set-volume", args.device, "-l", "1", f"{args.volume}%"])
        case "mute":
            run(["wpctl", "set-mute", args.device, "toggle"])
        case "listen":
            pactl_subscribe(args.device, args.type)
