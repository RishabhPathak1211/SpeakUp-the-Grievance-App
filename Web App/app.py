from flask import Flask, url_for, render_template, session, request, redirect
import pymongo
from bson import ObjectId
import bcrypt
import pandas
import xlrd
import json
import datetime
from text_classification import classify

client = pymongo.MongoClient("mongodb+srv://Rishabh_Pathak_12:speakup@cluster0.agd8b.mongodb.net/ThirdSemProj?retryWrites=true&w=majority")
db = client['ThirdSemProj']
comps = db['complaints']
dataset = db['Dataset']

def counts(col, user):
    count = {'hostelcount': 0, 'academicscount': 0, 'financecount': 0, 'messcount': 0}
    count['hostelcount'] = col.find({'category':'Hostel', 'institution':user}).count()
    count['academicscount'] = col.find({'category':'Academics', 'institution':user}).count()
    count['financecount'] = col.find({'category':'Finance', 'institution':user}).count()
    count['messcount'] = col.find({'category':'Mess', 'institution':user}).count()
    return count

def initials(name):
    parts = name.split()
    return str(parts[0][0]) + str(parts[-1][0])

app = Flask(__name__)
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'

@app.template_filter('date')
def complaint_date(date_time):
    return date_time.date().strftime('%d %B %Y')

@app.template_filter('time')
def complaint_time(date_time):
    return date_time.time()

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/aboutUs')
def about():
    return render_template('aboutus.html')

@app.route('/login', methods=['POST', 'GET'])
def login():
    if len(session.values()) == 0:
        if request.method == 'POST':
            users = db['Colleges']
            login_user = users.find_one({'name': request.form['username']})

            if login_user:
                if bcrypt.hashpw(request.form['password'].encode('utf-8'), login_user['password']) == login_user['password']:
                    session['username'] = request.form['username']
                    return redirect(url_for('complaints', user=session['username']))

            return 'Invalid Username/Password Combination'
        return render_template('hinex.html')
    else:
        return redirect(url_for('complaints', user=session['username']))

@app.route('/logout')
def logout():
    session.pop('username', None)
    return redirect(url_for('login'))

@app.route('/register', methods=['POST', 'GET'])
def register():
    if request.method == 'POST':
        users = db['Colleges']
        students = db['students']
        existing_user = users.find({'name': request.form['username']})

        if existing_user.count() == 0:
            uploaded_file = pandas.read_excel(request.files['file'])
            json_str = uploaded_file.to_json(orient='records')
            student_data = json.loads(json_str)
            for x in student_data:
                x['Institution'] = request.form['username']
                x['Password'] = bcrypt.hashpw(x['Password'].encode('utf-8'), bcrypt.gensalt())

            if isinstance(student_data, list):
                students.insert_many(student_data)
            else:
                students.insert_one(student_data)

            hashpass = bcrypt.hashpw(request.form['password'].encode('utf-8'), bcrypt.gensalt())
            users.insert_one({'name': request.form['username'], 'password': hashpass, 'address': request.form['address'], 'student_lst': student_data})
            session['username'] = request.form['username']
            return redirect(url_for('complaints', user=session['username']))

        return 'Username already exists'

    return render_template('register.html')

@app.route('/ourTeam')
def ourTeam():
    return render_template('ourteam.html')

@app.route('/contactUs')
def contactUs():
    return render_template('contact.html')

@app.route('/complaints/<user>')
def complaints(user):
    if user not in session.values():
        return redirect(url_for('login'))
    for x in comps.find({'institution':user, 'category':''}):
        id_x = x['_id']
        body = x['body']
        comps.update_one({'_id':ObjectId(id_x)}, {'$set': {'category':classify(body)}})
    return render_template('complaint.html', count=counts(comps, user), user=user)

@app.route('/complaint/<user>/<category>')
def complaintlist(user, category):
    if user not in session.values():
        return redirect(url_for('login'))
    comp_lst = []
    for x in comps.find({'institution':user, 'category':category}).sort('date', -1):
        comp_lst.append(x)
    return render_template('complaint.html', category=category, comp_lst=comp_lst, count=counts(comps, user), user=user, initials=initials)

@app.route('/complaint/<user>/<category>/<complaint_id>')
def complaint(user, category, complaint_id):
    if user not in session.values():
        return redirect(url_for('login'))
    rem_categories = ['Hostel', 'Academics', 'Finance', 'Mess']
    rem_categories.remove(category)
    comp_lst = []
    mycomp = []
    for x in comps.find({'institution':user, 'category':category}).sort('date', -1):
        comp_lst.append(x)
    for x in comps.find({'_id':ObjectId(complaint_id)}):
        mycomp.append(x)
    replylink = 'http://0dff94103831.ngrok.io/home/' + user
    return render_template('complaint.html', category=category, comp_lst=comp_lst, count=counts(comps, user), mycomp=mycomp, user=user, rem_cats=rem_categories, initials=initials, replylink=replylink)

@app.route('/confirmed/<complaint_id>')
def confirmed(complaint_id):
    x = comps.find_one({'_id':ObjectId(complaint_id)})
    found = dataset.find_one({'comp':x['body']})
    if not found:
        dataset.insert_one({'dept':x['category'], 'comp':x['body']})
        comps.update_one({'_id':ObjectId(complaint_id)}, {'$set': {'status':True}})
    return redirect(url_for('complaint', user=session['username'], category=x['category'], complaint_id=complaint_id))

@app.route('/changed/<complaint_id>/<new_category>')
def changed(complaint_id, new_category):
    x = comps.find_one({'_id':ObjectId(complaint_id)})
    if x['category'] != new_category:
        comps.update_one({'_id':ObjectId(complaint_id)}, {'$set': {'category':new_category}})
    return redirect(url_for('complaintlist', user=session['username'], category=x['category']))

if  __name__ == "__main__":
    app.run(port=8080)