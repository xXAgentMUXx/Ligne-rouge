from flask import Flask, render_template, request
import subprocess

app = Flask(__name__)

@app.route('/')
def index():
    return '''
        <h1>Gestion de Sauvegarde</h1>
        <button onclick="location.href='/sauvegarde'">Sauvegarder</button>
        <br><br>
        <form action="/restauration" method="post">
            <label for="vm">Restaurer depuis :</label>
            <select name="vm">
                <option value="VM1">VM1</option>
                <option value="VM3">VM3</option>
            </select>
            <button type="submit">Restaurer</button>
        </form>
    '''

@app.route('/sauvegarde')
def sauvegarde():
    try:
        subprocess.run(["sudo", "/home/vboxuser/sauvegarde3VM.sh"], check=True)
        return "Sauvegarde effectuée avec succès sur VM1 et VM3."
    except subprocess.CalledProcessError:
        return "Échec de la sauvegarde."

@app.route('/restauration', methods=['POST'])
def restauration():
    vm = request.form['vm']
    try:
        if vm == "192.168.56.101":
            subprocess.run(["sudo", "rsync", "-av", "vboxuser@VM1:/home/vboxuser/sauvegardes/", "/home/vboxuser/Documents/"], check=True)
        elif vm == "192.168.56.103":
            subprocess.run(["sudo", "rsync", "-av", "vboxuser@VM3:/home/vboxuser/sauvegardes2/", "/home/vboxuser/Documents/"], check=True)
        return f"Restauration effectuée avec succès depuis {vm}."
    except subprocess.CalledProcessError:
        return "Échec de la restauration."

if __name__ == '__main__':
    app.run(host='192.168.56.102', port=5000, debug=True)
