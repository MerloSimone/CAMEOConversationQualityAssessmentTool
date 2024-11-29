import sqlite3
import json
import os

con = sqlite3.connect("/root/.local/share/label-studio/label_studio.sqlite3")

cur = con.cursor()

res = cur.execute("SELECT * FROM authtoken_token")

user=res.fetchone()

print('Auth token: ',user[0])

with open('./authtoken.jsonl','w') as fp:
	print(json.dumps({'token':user[0]}),file=fp, flush= True )


