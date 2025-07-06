
import json
import requests
coingeckofile = "coingecko.json"  # Path to your JSON file
extendedfile = "extended_markets.json"  # Output file for extended data
def url_to_name(url):
    name = url.split('?')[0].split('/')
    return name[len(name)-1]
import os
OUTPUT_DIR = "../server/downloaded_images"
def download(url):
    try:
        filename = url_to_name(url)
        # Get image extension from URL

        filepath = os.path.join(OUTPUT_DIR, filename)
        if os.path.exists(filepath):
            return

        response = requests.get(url, timeout=10)
        response.raise_for_status()

        # Save the image
        with open(filepath, "wb") as f:
            f.write(response.content)
        print(f"Downloaded:{filename}")
    except Exception as e:
        print(f"Failed to download {url}: {e}")

def get_coin_id_by_name():
    url = "https://api.coingecko.com/api/v3/coins/list?include_platform=false"
    try:
        response = requests.get(url, timeout=10, headers={
            "Accept": "application/json",
            "x-cg-demo-api-key": "CG-ffoBeCmwQodwbv9ET5Mo7fB4",
            })
        response.raise_for_status()
        coins = response.json()

        return  coins
        

    except requests.RequestException as e:
        print(f"Request failed: {e}")
        return None

def get_coin_details(id):
    url = f"https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids={id}"
    try:
        response = requests.get(url, timeout=10, headers={
            "Accept": "application/json",
            "x-cg-demo-api-key": "CG-ffoBeCmwQodwbv9ET5Mo7fB4",
            })
        response.raise_for_status()
        coins = response.json()

        return  coins[0]
        

    except requests.RequestException as e:
        print(f"Request failed: {e}")
        return None


def get_coin_id(api = True):
    coin_id_by_name = []
    if api :
        coin_id_by_name = get_coin_id_by_name()
    else:
        with open("coin_list.json", "r") as file:
            coin_id_by_name = json.load(file)
    return coin_id_by_name


def get_coin_id_by_symbol(symbol):
    # Search for exact name match (case-insensitive)
        coins = get_coin_id(False)
        for coin in coins:
            if coin["symbol"].lower() == symbol.lower():
                return coin["id"]

        print(f"Coin named '{symbol}' not found.")
        return None


with open(coingeckofile, "r") as file:
    coingecko = json.load(file)
with open(extendedfile, "r") as file:
    extended = json.load(file)




    
# print("name to ",map)

extra = {
    "EUR": {
        "image": "https://s3-symbol-logo.tradingview.com/country/EU.svg",
        "name": "Euro"
    },
    "XBR": {
        "image": "https://cdn.extended.exchange/crypto/XBR.svg",
        "name": "Brent Crude Oil"
    },
    "USDJPY": {
        "image": "https://cdn.extended.exchange/crypto/USDJPY.svg",
        "name": "Japanese Yen"
    },
    "SPX500m": {
        "image": "https://cdn.extended.exchange/crypto/SPX500m.svg",
        "name": "S&P 500"
    },
    "TECH100m": {
       "image":  "https://cdn.extended.exchange/crypto/TECH100m.svg",
        "name": "Nasdaq 100"
    },
    "XAU":{
        "image": "https://cdn.extended.exchange/crypto/XAU.svg",
        "name": "Gold"
    },
    "1000PEPE": {
        "image": "https://cdn.extended.exchange/crypto/1000PEPE.svg",
        "name": "Pepe"
    }
}
map = {}
for i in coingecko:
    url = i['image']
    map[ i['symbol'].upper()] = [url_to_name(url), i['name']]
for sym, details in extra.items():
    url = details['image']
    download(url)
    map[ sym] = [url_to_name(url), details['name']]
    
final = {}
import sys
for i in extended['data']:
    symbol = i['assetName']
    # symbol  in eur , xbr

    # if symbol in ["EUR", "XBR", "USDJPY", "SPX500m", "TECH100m","1000PEPE", "XAU"]:
    #     final[symbol] = {
    #     "name": "Not available",
    #     "image": "Not available"
    # }
        # continue  # Skip EUR as per your request
    if len(x) == 0:
        # checks on lower
        id = get_coin_id_by_symbol(symbol)
        details = get_coin_details(id)
        url = details['image']
        download(url)
        filename = url_to_name(url)
        print(symbol)
        x = [filename, details['name']]
    final[symbol] = {
        "name": x[1],
        "image": x[0]
    }
print(final)
# remove eur