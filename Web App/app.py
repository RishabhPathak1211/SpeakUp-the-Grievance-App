from flask import Flask, url_for, render_template, session, request, redirect
import pymongo
from bson import ObjectId
import bcrypt

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
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'POST':
        users = db['Colleges']
        login_user = users.find_one({'name': request.form['username']})

        if login_user:
            if bcrypt.hashpw(request.form['password'].encode('utf-8'), login_user['password']) == login_user['password']:
                session['username'] = request.form['username']
                return redirect(url_for('complaints', user=session['username']))

        return 'Invalid Username/Password Combination'
    return render_template('hinex.html')

@app.route('/logout')
def logout():
    session.pop('username', None)
    return redirect(url_for('home'))

@app.route('/register', methods=['POST', 'GET'])
def register():
    if request.method == 'POST':
        users = db['Colleges']
        existing_user = users.find({'name': request.form['username']})

        if existing_user.count() == 0:
            hashpass = bcrypt.hashpw(request.form['password'].encode('utf-8'), bcrypt.gensalt())
            users.insert_one({'name': request.form['username'], 'password': hashpass, 'address': request.form['address']})
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
    return render_template('complaint.html', count=count, user=user)

@app.route('/complaint/<user>/<category>')
def complaintlist(user, category):
    if user not in session.values():
        return redirect(url_for('login'))
    comp_lst = []
    for x in col.find({'dept':category}):
        comp_lst.append(x)
    return render_template('complaint.html', category=category, comp_lst=comp_lst, count=count, user=user)

@app.route('/complaint/<user>/<category>/<complaint_id>')
def complaint(user, category, complaint_id):
    if user not in session.values():
        return redirect(url_for('login'))
    comp_lst = []
    mycomp = []
    for x in col.find({'dept':category}):
        comp_lst.append(x)
    for x in col.find({'_id':ObjectId(complaint_id)}):
        mycomp.append(x)
    return render_template('complaint.html', category=category, comp_lst=comp_lst, count=count, mycomp=mycomp, user=user)

if  __name__ == "__main__":
    app.run()