import pandas
import xlrd
import pymongo
import json
import bcrypt

client = pymongo.MongoClient('mongodb://localhost:27017/')
db = client['ThirdSemProj']
col = db['Students']

upload = pandas.read_excel('D:/Third semester project/StudentInfo.xlsx')
json_str = upload.to_json(orient='records')

data = json.loads(json_str)
print(data)
for x in data:
    x['Password'] = bcrypt.hashpw(x['Password'].encode('utf-8'), bcrypt.gensalt())
print(data)

col.insert_one({'name': 'BU', 'student_lst': data})