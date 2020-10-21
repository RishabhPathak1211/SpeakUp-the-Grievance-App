from flask import Flask, url_for, render_template
import pymongo
from bson import ObjectId

client = pymongo.MongoClient('mongodb://localhost:27017/')
db = client['ThirdSemProj']
col = db['Dataset']

count = {'hostelcount': 0, 'academicscount': 0, 'financecount': 0, 'messcount': 0}
for x in col.find({'dept':'Hostel'}):
    count['hostelcount'] += 1
for x in col.find({'dept':'Academics'}):
    count['academicscount'] += 1
for x in col.find({'dept':'Finance'}):
    count['financecount'] += 1
for x in col.find({'dept':'Mess'}):
    count['messcount'] += 1

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/login')
def login():
    return render_template('hinex.html')

@app.route('/ourTeam')
def ourTeam():
    return render_template('ourteam.html')

@app.route('/contactUs')
def contactUs():
    return render_template('contact.html')

@app.route('/complaints')
def complaints():
    return render_template('complaint.html', count=count)

@app.route('/complaint/<category>')
def complaintlist(category):
    comp_lst = []
    for x in col.find({'dept':category}):
        comp_lst.append(x)
    return render_template('complaint.html', category=category, comp_lst=comp_lst, count=count)

@app.route('/complaint/<category>/<complaint_id>')
def complaint(category, complaint_id):
    comp_lst = []
    mycomp = []
    for x in col.find({'dept':category}):
        comp_lst.append(x)
    for x in col.find({'_id':ObjectId(complaint_id)}):
        mycomp.append(x)
    return render_template('complaint.html', category=category, comp_lst=comp_lst, count=count, mycomp=mycomp)

if  __name__ == "__main__":
    app.run()