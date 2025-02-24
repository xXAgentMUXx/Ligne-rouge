from flask import Flask, render_template
import subprocess

app = Flask(__name__)

@app.route('/')
def index():
    return '''
        <h1>Gestion de Sauvegarde</h1>
        <button onclick="location.href='/sauvegarde'">Sauvegarder</button>
        <button onclick="location.href='/restauration'">Restaurer</button>
    '''

@app.route('/sauvegarde')
def sauvegarde():
    try:
        subprocess.run(["sudo", "rsync", "-av", "/home/vboxuser/Documents/", "/home/backupuser/backup/"], check=True)
        return "Sauvegarde effectuée avec succès !"
    except subprocess.CalledProcessError:
        return "Échec de la sauvegarde."

@app.route('/restauration')
def restauration():
    try:
        subprocess.run(["sudo", "rsync", "-av", "/home/backupuser/backup/", "/home/vboxuser/Documents/"], check=True)
        return "Restauration effectuée avec succès !"
    except subprocess.CalledProcessError:
        return "Échec de la restauration."

if __name__ == '__main__':
    app.run(host='10.0.2.15', port=5000, debug=True)
