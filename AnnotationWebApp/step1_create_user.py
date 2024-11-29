import pycurl
from io import BytesIO
import json
from urllib.parse import urlencode


user_data=[]
with open('./account.txt','r') as fp:
    for line in fp:
        user_data.append(line)

if len(user_data) != 2:
    raise Exception('Wrong Credentials Provided')

host_url = "http://localhost:8080/user/signup/"

buffer = BytesIO()

c = pycurl.Curl()
c.setopt(c.URL, host_url)
c.setopt(pycurl.TIMEOUT, 10)
c.setopt(pycurl.FOLLOWLOCATION, 1)
c.setopt(c.WRITEDATA, buffer)
c.setopt(pycurl.COOKIEJAR, './cookies.txt')
c.perform()
c.close()

body = buffer.getvalue().decode('iso-8859-1')

#print(body)

form_input="<input type=\"hidden\" name=\"csrfmiddlewaretoken\" value=\""

idx=body.find(form_input)

token=body[idx+len(form_input):idx+len(form_input)+64]

print('TOKEN: ',token)




host_url = "http://localhost:8080/user/signup/?&next=/projects/"

buffer = BytesIO()

data = {
    "csrfmiddlewaretoken": token,
    "email": user_data[0],
    "password": user_data[1],
    "allow_newsletters": "false"
}
postfields = urlencode(data)

c = pycurl.Curl()
c.setopt(c.URL, host_url)
c.setopt(pycurl.TIMEOUT, 10)
#c.setopt(pycurl.FOLLOWLOCATION, 1)
c.setopt(c.WRITEDATA, buffer)
c.setopt(pycurl.POSTFIELDS, postfields)
c.setopt(pycurl.COOKIEFILE, './cookies.txt')
c.setopt(pycurl.COOKIEJAR, './cookies2.txt')
c.perform()

print (f"STATUS CODE: {c.getinfo(pycurl.HTTP_CODE)}"  )

c.close()

body = buffer.getvalue().decode('iso-8859-1')

print(body)

