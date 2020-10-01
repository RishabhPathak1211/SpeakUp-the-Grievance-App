from flask import Flask, url_for, render_template

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

if  __name__ == "__main__":
    app.run()