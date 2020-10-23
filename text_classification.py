import pymongo
import re
import numpy
import pandas
from sklearn.datasets import load_files
from sklearn.utils import shuffle
from sklearn.feature_extraction.text import CountVectorizer, TfidfTransformer
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from sklearn.naive_bayes import GaussianNB
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
import nltk
#nltk.download('wordnet')
#nltk.download('stopwords')
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer

client = pymongo.MongoClient('mongodb://localhost:27017/')
database = client['ThirdSemProj']
collection = database['Dataset']

complaintsdf = pandas.DataFrame(list(collection.find()))
X, y = complaintsdf['comp'], complaintsdf['dept']

complaints = []
stemmer = WordNetLemmatizer()
for _ in range(len(X)):

    complaint = re.sub(r'\W', ' ', str(X[_]))
    complaint = re.sub(r'\s+[a-zA-Z]\s+', ' ', complaint)
    complaint = re.sub(r'\^[a-zA-Z]\s+', ' ', complaint)
    complaint = re.sub(r'\s+', ' ', complaint)
    complaint = re.sub(r'b\s+', '', complaint)
    complaint = complaint.lower()

    words = complaint.split()
    words = [stemmer.lemmatize(word) for word in words if word not in set(stopwords.words('english'))]
    complaint = ' '.join(words)
    complaints.append(complaint)

vectorizer = CountVectorizer(max_features=1500)
X = vectorizer.fit_transform(complaints).toarray()

transformer = TfidfTransformer()
X = transformer.fit_transform(X).toarray()

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.20, random_state=0)

SVMclassifier = SVC(kernel='rbf', random_state=0)
NBclassifier = GaussianNB()
DTclassifier = DecisionTreeClassifier(criterion='entropy', random_state=0)
RFclassifier = RandomForestClassifier(n_estimators=1000, random_state=0)

SVMclassifier.fit(X_train, y_train)
NBclassifier.fit(X_train, y_train)
DTclassifier.fit(X_train, y_train)
RFclassifier.fit(X_train, y_train)

svm_y_pred = SVMclassifier.predict(X_test)
nb_y_pred = NBclassifier.predict(X_test)
dt_y_pred = DTclassifier.predict(X_test)
rf_y_pred = RFclassifier.predict(X_test)

svm_as = accuracy_score(svm_y_pred, y_test)
nb_as = accuracy_score(nb_y_pred, y_test)
dt_as = accuracy_score(dt_y_pred, y_test)
rf_as = accuracy_score(rf_y_pred, y_test)

max_as = max(svm_as, nb_as, dt_as, rf_as)

test = input()

def classify(test):
    test_words = test.split()
    test_words = [stemmer.lemmatize(word) for word in test_words if word not in set(stopwords.words('english'))]
    test_words = ' '.join(test_words)
    test = [test_words]
    testx = vectorizer.transform(test).toarray()
    testx = transformer.transform(testx).toarray()

    category = ''
    model_used = ''
    if max_as == svm_as:
        model_used = 'svm'
        category = SVMclassifier.predict(testx)[0]
    elif max_as == nb_as:
        model_used = 'naive bayes'
        category = NBclassifier.predict(testx)[0]
    elif max_as == dt_as:
        model_used = 'decision tree'
        category = DTclassifier.predict(testx)[0]
    else:
        model_used = 'random forest'
        category = RFclassifier.predict(testx)[0]

    print(category)
    print(model_used)

classify(test)