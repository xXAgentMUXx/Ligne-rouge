import tkinter as tk
from tkinter import messagebox
import subprocess

def sauvegarde():
    try:
        subprocess.run(["pkexec", "/home/vboxuser/sauvegarde3VM.sh"], check=True)
        messagebox.showinfo("Succès", "Sauvegarde divisée envoyée sur VM2 et VM3.")
    except subprocess.CalledProcessError:
        messagebox.showerror("Erreur", "Échec de la sauvegarde.")

def restauration():
    try:
        subprocess.run(["pkexec", "/home/vboxuser/restauration3VM.sh"], check=True)
        messagebox.showinfo("Succès", "Restauration fusionnée réussie depuis VM2 et VM3.")
    except subprocess.CalledProcessError:
        messagebox.showerror("Erreur", "Échec de la restauration.")

# Interface Tkinter
tk_root = tk.Tk()
tk_root.title("Gestion Sauvegarde")
tk_root.geometry("300x200")

tk.Label(tk_root, text="Gestion de sauvegarde", font=("Arial", 14)).pack(pady=10)
tk.Button(tk_root, text="Sauvegarder", command=sauvegarde).pack(pady=5)
tk.Button(tk_root, text="Restaurer", command=restauration).pack(pady=5)

tk_root.mainloop()

