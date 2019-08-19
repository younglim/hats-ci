import platform

drivers = {
    "linux": {
        "65.0.3325": "drivers/linux/2.38",
        "68.0.3440": "drivers/linux/2.42",
        "70.0.3538": "drivers/linux/70.0.3538.97",
        "71.0.3578": "drivers/linux/71.0.3578.137",
        "72.0.3626": "drivers/linux/72.0.3626.69",
        "73.0.3683": "drivers/linux/73.0.3683.68",
        "74.0.3729": "drivers/linux/74.0.3729.6",
        "75.0.3770": "drivers/linux/75.0.3770.8"
    },
    "mac": {
        "65.0.3325": "drivers/mac/2.38",
        "68.0.3440": "drivers/mac/2.42",
        "70.0.3538": "drivers/mac/70.0.3538.97",
        "71.0.3578": "drivers/mac/71.0.3578.137",
        "72.0.3626": "drivers/mac/72.0.3626.69",
        "73.0.3683": "drivers/mac/73.0.3683.68",
        "74.0.3729": "drivers/mac/74.0.3729.6",
        "75.0.3770": "drivers/mac/75.0.3770.8"
    },
    "windows": {
        "65.0.3325": "drivers/windows/2.38",
        "68.0.3440": "drivers/windows/2.42",
        "70.0.3538": "drivers/windows/70.0.3538.97",
        "71.0.3578": "drivers/windows/71.0.3578.137",
        "72.0.3626": "drivers/windows/72.0.3626.69",
        "73.0.3683": "drivers/windows/73.0.3683.68",
        "74.0.3729": "drivers/windows/74.0.3729.6",
        "75.0.3770": "drivers/windows/75.0.3770.8"
    }
}

def get_chromedriver_path(version):
    print('Getting driver path for version ' + version )
    if platform.system() == "Linux":
        path = drivers['linux'][version]
        return path

    elif platform.system() == "Darwin":
        # OS X
        path = drivers['mac'][version]
        return path

    elif platform.system() == "Windows":
        path = drivers['windows'][version]
        return path