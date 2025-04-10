from flask import Flask
import subprocess

app = Flask(__name__)

@app.route('/')
def index():
    return '''
        <h1>Gestion de Sauvegarde</h1>
        <button onclick="location.href='/sauvegarde'">Sauvegarder</button>
        <br><br>
        <button onclick="location.href='/restauration'">Restaurer</button>
    '''

@app.route('/sauvegarde')
def sauvegarde():
    try:
        subprocess.run(["sudo", "/home/vboxuser/sauvegarde3VM.sh"], check=True)
        return "Sauvegarde divisée effectuée avec succès sur VM1 et VM3."
    except subprocess.CalledProcessError:
        return "Échec de la sauvegarde."

@app.route('/restauration')
def restauration():
    try:
        subprocess.run(["sudo", "/home/vboxuser/restauration3VM.sh"], check=True)
        return "Restauration fusionnée réussie depuis VM1 et VM3."
    except subprocess.CalledProcessError:
        return "Échec de la restauration."

if __name__ == '__main__':
    app.run(host='192.168.56.102', port=5000, debug=True)
