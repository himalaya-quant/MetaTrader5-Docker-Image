import MetaTrader5 as mt5
from datetime import datetime
import codecs
import json

path = "c:\\Program Files\\MetaTrader 5\\terminal64.exe"


def run_test():
    # connect to MetaTrader 5
    if not mt5.initialize(path):
        print("initialize() failed")
        mt5.shutdown()
        return

    # request connection status and parameters
    print(mt5.terminal_info())
    # get data on MetaTrader 5 version
    version = mt5.version()

    print(version)

    # request 1000 ticks from EURAUD
    data = mt5.copy_ticks_from("EURAUD", datetime(
        2020, 1, 28, 13), 1000, mt5.COPY_TICKS_ALL)

    file_path = "mt5-test-result.json"
    json.dump(data.tolist(), codecs.open(file_path, 'w', encoding='utf-8'),
              separators=(',', ':'),
              sort_keys=True,
              indent=4)

    mt5.shutdown()


run_test()
