import tkinter as tk
from tkinter import messagebox
import subprocess

def sauvegarde():
    try:
        subprocess.run(["pkexec", "/home/vboxuser/sauvegarde3VM.sh"], check=True)
        messagebox.showinfo("Succès", "Sauvegarde effectuée avec succès sur VM1 et VM2.")
    except subprocess.CalledProcessError:
        messagebox.showerror("Erreur", "Échec de la sauvegarde.")

def restauration():
    vm = var_vm.get()
    if vm == "VM1":
        cmd = ["pkexec", "rsync", "-av", "vboxuser@192.168.56.101:/home/vboxuser/sauvegardes2/", "/home/vboxuser/Documents/"]
    elif vm == "VM2":
        cmd = ["pkexec", "rsync", "-av", "vboxuser@192.168.56.102:/home/vboxuser/sauvegardes2/", "/home/vboxuser/Documents/"]
    else:
        messagebox.showerror("Erreur", "Veuillez choisir une source de restauration.")
        return
    
    try:
        subprocess.run(cmd, check=True)
        messagebox.showinfo("Succès", f"Restauration effectuée avec succès depuis {vm}.")
    except subprocess.CalledProcessError:
        messagebox.showerror("Erreur", "Échec de la restauration.")

# Interface Tkinter
tk_root = tk.Tk()
tk_root.title("Gestion Sauvegarde")
tk_root.geometry("300x250")

tk.Label(tk_root, text="Gestion de sauvegarde", font=("Arial", 14)).pack(pady=10)
tk.Button(tk_root, text="Sauvegarder", command=sauvegarde).pack(pady=5)

tk.Label(tk_root, text="Restaurer depuis :", font=("Arial", 12)).pack(pady=5)
var_vm = tk.StringVar(value="VM1")
tk.Radiobutton(tk_root, text="VM1", variable=var_vm, value="VM1").pack()
tk.Radiobutton(tk_root, text="VM2", variable=var_vm, value="VM2").pack()
tk.Button(tk_root, text="Restaurer", command=restauration).pack(pady=5)

tk_root.mainloop()
