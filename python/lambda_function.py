import json
import requests
import os
import boto3
import uuid
import sys

s3 = boto3.client('s3')
s3resource = boto3.resource('s3')
currencies = [ 'STOCK_USD','STOCK_EUR','STOCK_CAD','STOCK_GBP','STOCK_CHF' ]
ApiUrl = 'https://query1.finance.yahoo.com/v7/finance/quote?lang=en-US&region=US&corsDomain=finance.yahoo.com&fields=symbol,regularMarketPrice&symbols='
BucketName = os.environ['OUTPUT_BUCKET']
TmpFileName = "/tmp/temp_stocks.csv"
headers = {'User-Agent': 'My User Agent 1.0','From': 'youremail@domain.com'}

def lambda_handler(event, context):
    for currency in currencies:
        ApiUrlWithStock = ApiUrl + os.environ[currency]
        FileName = currency + ".csv"
        TempFile = open(TmpFileName, 'w')
        AllPrices = requests.get(ApiUrlWithStock, headers=headers)
        Response = AllPrices.json()
        AllQuotes = (Response['quoteResponse'])['result']
        for stock in range(0,len(AllQuotes)):
            Response_price = (Response['quoteResponse'])['result'][stock]['regularMarketPrice']
            Response_symbol = (Response['quoteResponse'])['result'][stock]['symbol']
            TempFile.write("%s,%s\n" % (Response_symbol, Response_price))
        TempFile.close()   
        with open(TmpFileName, 'rb') as f: #Open tmp file
            s3.upload_fileobj(f, BucketName,FileName) #Save tmp file to bucket
            object_acl = s3resource.ObjectAcl(BucketName,FileName).put(ACL='public-read') #Set S3 public ACL

    return {
        'statusCode': 200
    }