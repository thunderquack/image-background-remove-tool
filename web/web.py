# web/web.py

import sys
import os
import importlib.util
from flask import Flask, flash, request, redirect, url_for
from werkzeug.utils import secure_filename
from inspect import getmembers, isfunction

#MODULE_PATH = "/app/main.py"
#MODULE_NAME = "main"
#import importlib
#import sys
#spec = importlib.util.spec_from_file_location(MODULE_NAME, MODULE_PATH)
#main = importlib.util.module_from_spec(spec)
#sys.modules[spec.name] = main
#spec.loader.exec_module(main)

sys.path.append("/app/")
import main

UPLOAD_FOLDER = '/temp'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/')
def home():
    return "hello world!"


@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        # if user does not select file, browser also
        # submit an empty part without filename
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            fullName = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(fullName)
            func = getmembers(main)
            try:
                main.process_image(fullName, '/temp/out.jpg')
            except Exception:
                func = Exception
            #os.system('./main.py -i '+ fullName +
            #          ' -o /temp/temp.jpg -m basnet -prep bbd-fastrcnn -postp rtb-bnb')
            return str(func)
            return "OK"

    return '''
    <!doctype html>
    <title>Upload new File</title>
    <h1>Upload new File</h1>
    <form method=post enctype=multipart/form-data>
      <input type=file name=file>
      <input type=submit value=Upload>
    </form>
    '''


if __name__ == '__main__':
    app.secret_key = 'password'  # hahaha
    app.run(debug=True, host='0.0.0.0')
