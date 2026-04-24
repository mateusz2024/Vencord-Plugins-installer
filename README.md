# 🚀 Vencord Plugin Installer (Auto Setup Script)

## ⚙️ How it works
This script automatically:
- checks and installs **Git** (if missing)
- checks and installs **Node.js** (if missing)
- closes Discord during installation
- downloads and installs Vencord
- clones the Vencord repository into the Documents folder
- installs dependencies using `pnpm`
- creates a `userplugins` folder
- allows installing plugins from GitHub via link
- restarts Discord after setup

---

## ▶️ How to use
1. Download the `.bat` file  
2. Right-click it → **Run as Administrator**  
3. Follow the instructions in the terminal  

---

## 📁 Folder structure
After installation, the structure looks like this:
  Documents/
    └── Vencord/
      ├── src/
      │ └── userplugins/
      │ └── (your plugins go here)



---

## 🔍 Where to get plugins
You can find Vencord plugins on GitHub:
- https://github.com/topics/vencord-plugin
- https://github.com/topics/vencord-plugin
- https://github.com/topics/vencord

📌 Plugins (open repo, click green **Code** button, copy HTTPS link or add `.git`, read README and check compatibility)

---

## 🧩 Plugin installation
- the script asks for a GitHub repository URL  
- the plugin is cloned into `userplugins`  
- Vencord automatically loads it  

---

## ⚠️ Requirements
- Windows 10 / 11  
- Internet connection  
- (recommended) administrator privileges  
- **Discord installed**: https://discord.com/download  

---

## 🧠 Author
wimiz - matuesz2024  

---

## ❗ Disclaimer
The author is not responsible for:
- system errors or crashes  
- Discord or Vencord issues  
- effects caused by plugins or script usage  
- any damage resulting from installation or use of this software  
