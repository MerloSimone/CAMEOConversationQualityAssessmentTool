import pycurl
from io import BytesIO
import json




authtoken=None
with open('./authtoken.jsonl','r') as fp:
    for line in fp:
        data = json.loads(line)
        authtoken=data["token"]

if authtoken is None:
    raise Exception('Something went wrong, authtoken unreadable')
else:
    print("Loaded token: ",authtoken)


reg_num=None
with open('./data/current_reg_num.txt','r') as fp:
    for line in fp:
        reg_num = line.strip()

if reg_num is None:
    raise Exception('Something went wrong, registration number (Matricola) unreadable')
else:
    print("Loaded reg num: ",reg_num)

curl = pycurl.Curl()

url = 'http://localhost:8080/api/projects/1/import'
curl.setopt(curl.URL, url)


curl.setopt(curl.POST, True)


curl.setopt(curl.HTTPHEADER, [
    f'Authorization: {authtoken}'
])


file_path = f'./data/label_studio_in_files/{reg_num}.json'
curl.setopt(curl.HTTPPOST, [
    ('file', (curl.FORM_FILE, file_path))
])


response_buffer = BytesIO()
curl.setopt(curl.WRITEDATA, response_buffer)
curl.setopt(pycurl.COOKIEFILE, './cookies2.txt')


try:
    curl.perform()
    status_code = curl.getinfo(pycurl.RESPONSE_CODE) 
    print(f"Status Code: {status_code}")
    response = response_buffer.getvalue().decode('utf-8')
    print("Response:", response)
except pycurl.error as e:
    print(f"An error occurred: {e}")
finally:

    curl.close()
