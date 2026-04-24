# 🚀 Vencord Plugin Installer (Auto Setup Script)

This batch script automatically installs and configures a full Vencord environment and makes it easy to install plugins.

---

## ⚙️ What this script does

When you run the script, it will:

### 🔧 Automatic dependency setup
- Checks if **Git** is installed
  - If not → downloads and installs it automatically
- Checks if **Node.js** is installed
  - If not → downloads and installs it automatically

---

### 💬 Discord handling
- Closes Discord at the start of the process
- Restarts Discord automatically at the end

---

### 📦 Vencord setup
- Downloads the Vencord installer
- Runs the installer
- Clones the Vencord repository into your Documents folder
- Installs required dependencies using `pnpm`

---

## 🔍 Where to find Vencord plugins

You can find ready-made plugins and inspiration for creating your own in the following places:

### 📦 GitHub (Vencord community)
- https://github.com/topics/vencord-plugin  
- https://github.com/topics/vencord-plugin  
- https://github.com/topics/vencord  

### 💡 Tips
- Look for repositories tagged with `vencord-plugin`
- Always check the plugin’s README before installing
- Make sure the plugin is up to date and compatible with your Vencord version

### 🧩 Plugin system
- Creates a `userplugins` folder (if it doesn't exist)
- Asks for a plugin Git repository URL
- Clones the plugin into the Vencord `userplugins` directory

---

## 📁 Resulting folder structure
Documents/
└── Vencord/
├── src/
│ └── userplugins/
│ └── your-plugin-repository


---

## ▶️ How to use

1. Download the `.bat` file
2. Right-click it → **Run as Administrator**
3. Follow the instructions in the terminal

---

## ⚠️ Requirements

- Windows 10 / 11
- Internet connection
- Administrator privileges (recommended)

---

## 🧠 Notes

- The script automatically installs missing dependencies
- If Git or Node.js are already installed, they will be skipped
- Discord is automatically restarted after setup

---

## 📌 Author

wimiz - matuesz2024
