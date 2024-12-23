import pycurl
import json
from io import StringIO

authtoken=None
with open('./authtoken.jsonl','r') as fp:
	for line in fp:
		data = json.loads(line)
		authtoken=data["token"]

if authtoken is None:
	raise Exception('Something went wrong, authtoken unreadable')
else:
	print("Loaded token: ",authtoken)


label_config=""

with open('./data/labelstudio_INTERFACE.txt','r') as fp:
	for line in fp:
		label_config+=line.strip()

if label_config is None:
	raise Exception('Something went wrong, label config unreadable')
else:
	print("Loaded label config")
	print(label_config)



curl = pycurl.Curl()
curl.setopt(pycurl.URL, 'http://localhost:8080/api/projects')
curl.setopt(pycurl.HTTPHEADER, ['Accept: application/json','Content-Type: application/json',f'Authorization: {authtoken}'])
curl.setopt(pycurl.POST, 1)

curl.setopt(pycurl.TIMEOUT, 10)


body_as_dict = {"title": "Conversation Quality Assessment", "description": "Conversation Quality Assessment Task", "enable_empty_annotation": False,"maximum_annotations": 1,"expert_instruction": "Label all conversations and all properties", "label_config": label_config}
body_as_json_string = json.dumps(body_as_dict) # dict to json
body_as_file_object = StringIO(body_as_json_string)


curl.setopt(pycurl.READDATA, body_as_file_object) 
curl.setopt(pycurl.POSTFIELDSIZE, len(body_as_json_string))
curl.setopt(pycurl.COOKIEFILE, './cookies2.txt')
curl.perform()


status_code = curl.getinfo(pycurl.RESPONSE_CODE)
if status_code != 200:
    print("Aww Snap :( Server returned HTTP status code {}".format(status_code))


curl.close()
