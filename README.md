# 🚀 Vencord Plugin Installer (Auto Setup Script)

<<<<<<< HEAD
**Repo:** https://github.com/mateusz2024/Vencord-Plugins-installer

## ⚙️ How it works

This script automatically:

=======
## ⚙️ How it works
This script automatically:
>>>>>>> fc48a68c4e0571cdd8a7984e79247f40085d6689
- checks and installs **Git** (if missing)
- checks and installs **Node.js** (if missing)
- closes Discord during installation
- downloads and installs Vencord
- clones the Vencord repository into the Documents folder
- installs dependencies using `pnpm`
- creates a `userplugins` folder
<<<<<<< HEAD
- shows a clean, paginated menu to install one or more plugins:
  - skip and install with no extra plugins
  - pick from a predefined list of 17+ plugin sources (several of which are
    bundles containing multiple plugins each)
  - or paste your own custom plugin repository URL
- automatically fixes plugin repos that nest their code inside a subfolder
  instead of putting `index.ts`/`index.tsx` at the repo root
- rebuilds Vencord and injects it
=======
- allows installing plugins from GitHub via link
>>>>>>> fc48a68c4e0571cdd8a7984e79247f40085d6689
- restarts Discord after setup

---

## ▶️ How to use
1. Download the `.bat` file  
2. Right-click it → **Run as Administrator**  
3. Follow the instructions in the terminal  

<<<<<<< HEAD
1. Download the `.bat` file
2. Right-click it → **Run as Administrator**
3. Follow the instructions in the terminal
4. Pick a plugin option from the menu (or skip)
5. Once Discord restarts, open **Vencord Settings → Plugins** and manually
   toggle ON any plugin(s) you just installed — new plugins are **not**
   enabled by default

---

## 🧩 Available plugins in the menu

**Page 1**
1. Complete Discord Quest — auto-completes Discord quests in the background
2. Fake Voice Options — adds fake/extra voice channel settings
3. Mute Alert — plays a sound alert when you get muted/unmuted
4. Giphy Gif Search — search and send GIFs from Giphy directly in chat
5. Vencord Shazam — identifies songs playing in a voice channel
6. Plugin Repo — browse and install other third-party plugins from inside Discord
7. Quest Completer (alt) — an alternative, simpler quest-completing plugin
8. VencordPlugins (verticalsync) — **bundle** of several community plugins
9. vc-plugins (ImLvna) — **bundle** of several community plugins

**Page 2**
10. D3SOX Userplugins — **bundle**: BetterActivities, FollowUser, SilentTyping, VoiceChatUtilities, MediaPlaybackSpeed and more
11. ErdbeerbaerLP Userplugins — **bundle** of various custom plugins
12. nmsturcke Vencord-Plugins — **bundle** of handy plugins not in official Vencord
13. 002-sans VencordPlugins — **bundle**: badge selectors, custom UI tweaks and more
14. owoyi Userplugins — **bundle**: AutoAttendance, SendButton and more
15. zaher-neon Userplugins — **bundle** of various custom mods
16. theokyr Vencord-Plugins — **bundle**: UI enhancements, keyboard navigation, dev tools
17. coreknee VencordPlugins — **bundle** of assorted third-party plugins

You can also press `[3]` in the main plugin menu at any time to paste any
other plugin's GitHub URL yourself.

---

## 📁 Folder structure

After installation, the structure looks like this:

```
Documents/
└── Vencord/
    ├── src/
    │   └── userplugins/
    │       └── (your plugins go here)
```

---

## 🔍 Where to find more plugins

You can browse more Vencord plugins on GitHub:

- https://github.com/topics/vencord-plugin
- https://github.com/topics/vencord-userplugin
- https://github.com/topics/vencord-plugins

📌 Open a repo, click the green **Code** button, copy the HTTPS link, and
paste it into option `[3]` (Custom URL) in the script's plugin menu. Always
read the plugin's README first to check compatibility.
=======
---

## 📁 Folder structure
After installation, the structure looks like this:
  Documents/
-    └── Vencord/
 -     ├── src/
 -     │ └── userplugins/
 -     │ └── (your plugins go here)



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
>>>>>>> fc48a68c4e0571cdd8a7984e79247f40085d6689

---

## ⚠️ Requirements
<<<<<<< HEAD

- Windows 10 / 11
- Internet connection
- (recommended) administrator privileges
- **Discord installed**: https://discord.com/download
=======
- Windows 10 / 11  
- Internet connection  
- (recommended) administrator privileges  
- **Discord installed**: https://discord.com/download  
>>>>>>> fc48a68c4e0571cdd8a7984e79247f40085d6689

---

## 🧠 Author
<<<<<<< HEAD

wimiz - mateusz2024
=======
wimiz - matuesz2024  
>>>>>>> fc48a68c4e0571cdd8a7984e79247f40085d6689

---

## ❗ Disclaimer
<<<<<<< HEAD

The author is not responsible for:

- system errors or crashes
- Discord or Vencord issues
- effects caused by plugins or script usage
- any damage resulting from installation or use of this software

Some plugins (particularly quest-completion plugins) automate parts of the
Discord client and may go against Discord's Terms of Service. Use them at
your own risk.
=======
The author is not responsible for:
- system errors or crashes  
- Discord or Vencord issues  
- effects caused by plugins or script usage  
- any damage resulting from installation or use of this software  
>>>>>>> fc48a68c4e0571cdd8a7984e79247f40085d6689
