# # from smartapi import SmartConnect
# # import time as tt
# # import pandas as pd
# # import login as l 
# # pd.set_option('max_columns', None)
# # from datetime import datetime, date, time
# # import datetime
# # def initializeSymbolTokenMap():
# #     url = 'https://margincalculator.angelbroking.com/OpenAPI_File/files/OpenAPIScripMaster.json'
# #     d = requests.get(url).json()
# #     global token_df
# #     token_df = pd.DataFrame.from_dict(d)
# #     token_df['expiry'] = pd.to_datetime(token_df['expiry'])
# #     token_df = token_df.astype({'strike': float})
# #     l.token_map = token_df
# # def getTokenInfo (exch_seg,instrumenttype,symbol,strike_price,pe_ce):
# #     df = token_map
# #     strike_price = strike_price*100
# #     if exch_seg == 'NFO' &  (instrumenttype == 'OPTSTK' or instrumenttype == 'OPTIDX'):
# #         return df[(df ['excpt_seg']) == 'NFO' & (df[instrumenttype]  == instrumenttype) & (df['name'] == symbol) & (df['strike'] == strike_price) & (df['symbol'].str.endswith(pe_ce)) & (df['expiry']>= str (datetime.date.today()))].sort_values
    

# # def getCandleData(symbolInfo):
# #     try:
# #         historicParam={
# #         "exchange": symbolInfo.exch_seg,
# #         "symboltoken":symbolInfo.token,
# #         "interval":"FIVE_MINUTE",
# #         "fromdate":f'{date.today()-datetime.timedelta(90)} 09:15',
# #         "today":f'{date.today()-datetime.timedelta(1)} 15:30'
# #         }
# #         res_json = obj.getCandleData(historicParam)
# #         columns = ['timestamp','open','high','low','close','volume']
# #         df = pd.DataFrame(res_json['data'],columns=columns)
# #         df['timestamp'] = pd.to_datetime(df['timestamp'],format='%Y-%m-%dT%H:%M:%S')
# #         df['symbol'] = symbolInfo.symbol
# #         df['expiry'] = symbolInfo.expiry
# #         print(f"Done for {symboINfo.symbol}")
# #         print(df)
# #         tt.sleep(0.2)
# #         return df
# #     except Exception as e:
# #         print(f"Historic Api failed{e} {symbolInfo.symbol}")


# # obj = SmartConnect(api_key = l.api_key)
# # data = obj.generateSession(l.user_name,l.password)
# # refreshToken = data['data']['refreshToken']
# # feedToken= obj.getfeedToken()
# # l.feed_token = feedToken

# # initializeSymbolTokenMap()

# # tokenInfo = getTokenInfo('NFO','OPTIDX','NIFTY',17800,'CE').iloc[0]
# # print(tokenInfo)
# # symbol = tokenInfo['symbol']
# # token = tokenInfo['token']
# # lot = int(tokenInfo['lotsize'])
# # print(symbol,token,lot)



# # import requests
# # import base64
# # import json

# # paytmParams = dict()

# # paytmParams["grantType"] = "authorization_code"
# # paytmParams["cpde"]      = "999e3877-97c1-XXXX-b19d-6c8787983300"
# # paytmParams["deviceId"]  = "Device123"

# # post_data = json.dumps(paytmParams)

# # auth = "Basic " + ("9682524922:9682524922")

# # # for Staging
# # url = "https://accounts-uat.paytm.com/oauth2/v3/token/sv1/"

# # # for Production
# # # url = "https://accounts.paytm.com/oauth2/v3/token/sv1/"
# # response = requests.post(url, data = post_data, headers = {"Authorization": auth,"Content-type": "application/json"}).json()
# # print(response)   




# # import requests

# # url = 'https://developer.paytmmoney.com/accounts/v2/gettoken'
# # myobj = {'api_key': 'd033d7b58d174c5dbaca03d2c655c311','api_secret_key':'0d5a963aef7d40f7bb333449f5a0e18c',"request_token": "requestToken"}

# # x = requests.post(url, json = myobj)

# # print(x.text)

# # # getCandleData(tokenInfo)
# # import requests
# # import json

# # url = 'https://developer.paytmmoney.com/accounts/v2/gettoken'
# # headers = {'Content-Type': 'application/json'}
# # payload = {
# #     "api_key": "{{d033d7b58d174c5dbaca03d2c655c311}}",
# #     "api_secret_key": "{{0d5a963aef7d40f7bb333449f5a0e18c}}",
# #     "request_token": "{{requestToken}}"
# # }
# # data = json.dumps(payload)

# # response = requests.post(url, headers=headers, data=data)
# # print(response.text) 

# # import requests

# # url = 'https://developer.paytmmoney.com/fno/v1/option-chain'
# # params = {'type': 'PUT', 'symbol': 'NIFTY', 'expiry': '23-02-2023'}
# # headers = {'x-jwt-token': '{{eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJtZXJjaGFudCIsImlzcyI6InBheXRtbW9uZXkiLCJpZCI6NzY0MTgsImV4cCI6MTY4MDI4NzM5OX0.tfnayQq8ioYUtZxrjM0Cux9E4-YqR08tOUc1JnhGtTI}}'}

# # response = requests.get(url, params=params, headers=headers)
# # print(response.text)
# # import requests

# # api_key = "{{d033d7b58d174c5dbaca03d2c655c311}}"
# # state_key = "{{9682524922}}"
# # url = f"https://login.paytmmoney.com/merchant-login?apiKey={api_key}&state={state_key}"
# # response = requests.get(url)
# # print(response.text)
# # import requests
# # import json

# # url = "https://developer.paytmmoney.com/orders/v1/place/regular"
# # jwt_token = "{{eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJtZXJjaGFudCIsImlzcyI6InBheXRtbW9uZXkiLCJpZCI6NzY0MTgsImV4cCI6MTY4MDI4NzM5OX0.tfnayQq8ioYUtZxrjM0Cux9E4-YqR08tOUc1JnhGtTI}}"
# # payload = {
# #     "txn_type": "B",
# #     "exchange": "BSE",
# #     "segment": "E",
# #     "product": "I",
# #     "security_id": "500570",
# #     "quantity": 2,
# #     "validity": "DAY",
# #     "order_type": "MKT",
# #     "price": 0,
# #     "source": "N",
# #     "off_mkt_flag": "false"
# # }
# # headers = {
# #     "x-jwt-token": jwt_token,
# #     "Content-Type": "application/json"
# # }
# # response = requests.post(url, data=json.dumps(payload), headers=headers)
# # print(response.json())

# # import http.client

# # conn = http.client.HTTPSConnection("apiconnect.angelbroking.com")
# # payload = "{\r\n     \"exchange\": \"NSE\",\r\n  \"symboltoken\": \"1232\",\r\n \"interval\": \"ONE_MINUTE\",\r\n \"fromdate\": \"2023-03-17 09:30\",\r\n     \"todate\": \"2023-03-17 09:31\"\r\n}"
# # headers = {
# #   'X-PrivateKey': 'NlqvYF0s',
# #   'Accept': 'application/json',
# #   'X-SourceID': 'WEB',
# #   'X-ClientLocalIP': 'CLIENT_LOCAL_IP',
# #   'X-ClientPublicIP': 'CLIENT_PUBLIC_IP',
# #   'X-MACAddress': 'MAC_ADDRESS',
# #   'X-UserType': 'S1034526',
# #   'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJ1c2VybmFtZSI6IlMxMDM0NTI2Iiwicm9sZXMiOjAsInVzZXJ0eXBlIjoiVVNFUiIsImlhdCI6MTY3NzMwMDE2MCwiZXhwIjoxNzYzNzAwMTYwfQ.opHDh1sU3JopdfYT7eUrnhl61GCrg444xv8sKrDbKoHgB7B55N6fRJ6o7z20tn0lDk2YJoaC6qFiJ33cYhQdOg',
# #   'Accept': 'application/json',
# #   'X-SourceID': 'WEB',
# #   'Content-Type': 'application/json'
# # }
# # conn.request("POST", "/rest/secure/angelbroking/historical/v1/getCandleData", payload, headers)
# # res = conn.getresponse()
# # data = res.read()
# # print(data.decode("utf-8"))

# # import websocket
# # import ssl

# # def on_message(ws, message):
# #     print(message)

# # def on_error(ws, error):
# #     print(error)

# # def on_close(ws):
# #     print("Connection closed")

# # def on_open(ws):
# #     print("Connection established")

# # if __name__ == "__main__":
# #     # establish connection
# #     websocket.enableTrace(True)
# #     client_code = "S1034526"
# #     feed_token = "0812778868"
# #     ws_url = f"wss://omnefeeds.angelbroking.com/NestHtml5Mobile/socket/stream?CLIENT_CODE={client_code}&FEED_TOKEN={feed_token}"
# #     sslopt = {"cert_reqs": ssl.CERT_NONE}
# #     ws = websocket.create_connection(ws_url, sslopt=sslopt)
# #     ws.send("Hello, World!")
# #     result = ws.recv()
# #     print(result)
# #     ws.run_forever()



# import http.client
# import mimetypes
# conn = http.client.HTTPSConnection(
#     "apiconnect.angelbroking.com"
#     )
# payload = "{\n\"clientcode\":\"S1034526\",\n\"password\":\"0089\"\n,\n\"totp\":\"097618\"\n}"
# headers = {
#     'Content-Type': 'application/json',
#     'Accept': 'application/json',
#     'X-UserType': 'USER',
#     'X-SourceID': 'WEB',
#     'X-ClientLocalIP': 'CLIENT_LOCAL_IP',
#     'X-ClientPublicIP': 'CLIENT_PUBLIC_IP',
#     'X-MACAddress': 'MAC_ADDRESS',
#     'X-PrivateKey': 'NlqvYF0s'
#   }
# conn.request("POST","/rest/auth/angelbroking/user/v1/loginByPassword",payload,
#      headers)

# res = conn.getresponse()
# data = res.read()
# print(data.decode("utf-8"))





# # login id  S1034526
# # api key   NlqvYF0s
# # totp key W2VR2SJX2OC3HRF7HSGEIOQTZ4
# # secret key c9102a3d-c9c2-4e3f-bbe2-74a3dcf90a62 
# # jwt token eyJhbGciOiJIUzUxMiJ9.eyJ1c2VybmFtZSI6IlMxMDM0NTI2Iiwicm9sZXMiOjAsInVzZXJ0eXBlIjoiVVNFUiIsImlhdCI6MTY3NzMwMDE2MCwiZXhwIjoxNzYzNzAwMTYwfQ.opHDh1sU3JopdfYT7eUrnhl61GCrg444xv8sKrDbKoHgB7B55N6fRJ6o7z20tn0lDk2YJoaC6qFiJ33cYhQdOg
# # "refreshToken":"eyJhbGciOiJIUzUxMiJ9.eyJ0b2tlbiI6IlJFRlJFU0gtVE9LRU4iLCJpYXQiOjE2NzczMDAxNjB9.x30PlUzWwqnjdT9qHE8Emvl7Ln-k-djGH5VvVVtiEgmcgS6k1Bjv9qAaeCR4_BQawJsc9ZmcpqRFujuaW01W8A"
# # "feedToken":"0812778868"


# from upstox_api.api import *

# s = Session ('your_api_key')
# s.set_redirect_uri ('your_redirect_uri')
# s.set_api_secret ('your_api_secret')

# print (s.get_login_url())
# s.set_code ('your_code_from_login_response')

# access_token = s.retrieve_access_token()
# print ('Received access_token: %s' % access_token)

import http.client

conn = http.client.HTTPSConnection("apiconnect.angelbroking.com")
payload = "{\r\n     \"exchange\": \"NSE\",\r\n   \"symboltoken\": \"3045\",\r\n    \"interval\": \"ONE_MINUTE\",\r\n      \"fromdate\": \"2021-02-08 09:00\",\r\n     \"todate\": \"2021-02-08 09:16\"\r\n}"
headers = {
  'X-PrivateKey': 'NlqvYF0s',
  'Accept': 'application/json',
  'X-SourceID': 'WEB',
  'X-ClientLocalIP': 'CLIENT_LOCAL_IP',
  'X-ClientPublicIP': 'CLIENT_PUBLIC_IP',
  'X-MACAddress': 'MAC_ADDRESS',
  'X-UserType': 'USER',
  'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJ1c2VybmFtZSI6IlMxMDM0NTI2Iiwicm9sZXMiOjAsInVzZXJ0eXBlIjoiVVNFUiIsImlhdCI6MTY3NzMwMDE2MCwiZXhwIjoxNzYzNzAwMTYwfQ.opHDh1sU3JopdfYT7eUrnhl61GCrg444xv8sKrDbKoHgB7B55N6fRJ6o7z20tn0lDk2YJoaC6qFiJ33cYhQdOg',
  'Accept': 'application/json',
  'X-SourceID': 'WEB',
  'Content-Type': 'application/json'
}
conn.request("POST", "/rest/secure/angelbroking/historical/v1/getCandleData", payload, headers)
res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))