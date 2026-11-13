<p align="center">
  <img src="Perchly/Assets.xcassets/AppIcon.appiconset/icon_256x256.png" width="128" alt="Perchly icon">
</p>

<h1 align="center">Perchly</h1>

<p align="center">Instagram's mobile layout, one click away in your Mac menu bar.</p>

<p align="center">
  <a href="https://github.com/calvinlee326/Perchly/releases/latest/download/Perchly.zip"><b>Download Perchly for Mac</b></a>
  <br>
  Apple Silicon (M1 or later) · macOS 14 Sonoma or later
</p>

[English](#install) · [繁體中文](#安裝方式)

---

## Install

1. [Download `Perchly.zip`](https://github.com/calvinlee326/Perchly/releases/latest/download/Perchly.zip) and double-click it to unzip.
2. Drag **Perchly.app** into your **Applications** folder.
3. Open Perchly. macOS will say it *"could not verify Perchly is free of malware"*. Click **Done** (not Move to Trash).
4. Open **System Settings → Privacy & Security**, scroll down to **Security**, and click **Open Anyway** next to *"Perchly was blocked"*.
5. Click **Open Anyway** again and enter your Mac password. You only need to do this once.
6. Perchly appears as an icon in the **menu bar** at the top-right of your screen. Click it and log in to Instagram.

> **Why the warning?** Perchly isn't notarized by Apple yet, so macOS asks you to confirm the first launch.

**Prefer Terminal?** Steps 3 to 5 can be replaced with:

```sh
xattr -dr com.apple.quarantine /Applications/Perchly.app
```

### Can't find the icon?

On MacBooks with a notch, extra menu bar icons can hide behind it. Quit a few other menu bar apps, or hold **⌘** and drag icons to rearrange them. Also check **System Settings → Menu Bar** that Perchly is allowed.

## Privacy

- You log in on Instagram's own page. Perchly never sees or stores your password.
- Your login session stays on your Mac, inside Perchly's sandbox.
- No analytics, no tracking, no servers of our own.

## Quit and uninstall

- **Quit:** click **Quit** at the bottom of the Perchly window.
- **Uninstall:** quit Perchly, then move these to the Trash:
  - `/Applications/Perchly.app`
  - `~/Library/Containers/com.calvinlee326.perchly` (your login session)

---

## 安裝方式

1. [下載 `Perchly.zip`](https://github.com/calvinlee326/Perchly/releases/latest/download/Perchly.zip)，雙擊解壓縮。
2. 把 **Perchly.app** 拖進「**應用程式**」資料夾。
3. 打開 Perchly。macOS 會顯示「Apple 無法驗證 Perchly 是否不含惡意軟體」，請按「**完成**」，不要按「移到垃圾桶」。
4. 打開「**系統設定 → 隱私權與安全性**」，往下捲到「**安全性**」，在「已阻擋 Perchly」旁邊按「**強制打開**」。
5. 再按一次「**強制打開**」並輸入電腦密碼。只有第一次需要這樣做。
6. 螢幕右上角的**選單列**會出現 Perchly 的圖示，點它就能登入 Instagram。

> **為什麼會有警告？** Perchly 目前還沒有經過 Apple 公證，所以第一次打開時 macOS 會請你確認。

**會用終端機的話**，第 3 到 5 步可以改成執行：

```sh
xattr -dr com.apple.quarantine /Applications/Perchly.app
```

### 找不到圖示？

有瀏海的 MacBook，選單列圖示太多時會被瀏海擋住。可以先關掉幾個其他的選單列 App，或按住 **⌘** 拖曳圖示調整位置。也請到「**系統設定 → 選單列**」確認 Perchly 沒有被關閉。

## 隱私

- 你是在 Instagram 自己的登入頁登入，Perchly 不會看到也不會儲存你的密碼。
- 登入狀態只存在你的 Mac 上，在 Perchly 的沙盒裡。
- 沒有數據分析、沒有追蹤，也沒有我們自己的伺服器。

## 結束與移除

- **結束：** 點 Perchly 視窗最下方的 **Quit**。
- **移除：** 先結束 Perchly，再把這兩個丟進垃圾桶：
  - `/Applications/Perchly.app`
  - `~/Library/Containers/com.calvinlee326.perchly`（你的登入資料）

---

Perchly is an independent project and is not affiliated with, endorsed by, or sponsored by Instagram or Meta.

Perchly 是獨立開發的專案，與 Instagram 或 Meta 沒有任何關聯。
