import { app, shell, BrowserWindow, ipcMain, Tray, Menu, nativeImage } from "electron"
import { join } from "path"
import { electronApp, optimizer, is } from "@electron-toolkit/utils"
import { event_global } from "./event/event_global"
import { event_window } from "./event/event_window"
import icon from "../../resources/icon.png?asset"
import { APP_HEIGHT, APP_WIDTH } from "./config"

import { initializeDragPlus } from "electron-drag-plus"

app.whenReady().then(() => {
    electronApp.setAppUserModelId("com.electron")
    app.on("browser-window-created", (_, window) => {
        optimizer.watchWindowShortcuts(window)
    })
    const gotTheLock = app.requestSingleInstanceLock()
    if (!gotTheLock) {
        app.quit()
    }
    createWindow()
    app.on("activate", function () {
        if (BrowserWindow.getAllWindows().length === 0) createWindow()
    })
})

import { useMainWindow } from "./app"
let { setMainWindow } = useMainWindow()

function createWindow() {
    let mainWindow = new BrowserWindow({
        width: APP_WIDTH,
        height: APP_HEIGHT,
        minWidth: APP_WIDTH,
        minHeight: APP_HEIGHT,
        backgroundColor: "#ffffff",
        show: false,
        frame: false,
        autoHideMenuBar: true,
        ...(process.platform === "linux" ? { icon } : {}),
        webPreferences: {
            devTools: true,
            preload: join(__dirname, "../preload/index.js"),
            sandbox: false
        }
    })
    event_window(ipcMain, mainWindow)
    initializeDragPlus(mainWindow)

    event_global(ipcMain, app)

    mainWindow.webContents.openDevTools()

    mainWindow.webContents.session.on("select-hid-device", (_event, _details, _callback) => { })
    mainWindow.webContents.session.setPermissionCheckHandler(
        (_webContents, _permission, _requestingOrigin, _details) => {
            return true
        }
    )
    mainWindow.webContents.session.setDevicePermissionHandler((_details) => {
        return true
    })
    mainWindow.on("ready-to-show", () => {
        mainWindow?.show()
    })
    mainWindow.webContents.setWindowOpenHandler((details) => {
        shell.openExternal(details.url)
        return { action: "deny" }
    })

    if (is.dev && process.env["ELECTRON_RENDERER_URL"]) {
        mainWindow.loadURL(process.env["ELECTRON_RENDERER_URL"])
    } else {
        mainWindow.loadFile(join(__dirname, "../renderer/index.html"))
    }
    // 托盘图标和菜单
    const tray = new Tray(nativeImage.createFromPath(icon))
    const contextMenu = Menu.buildFromTemplate([
        {
            label: "app",
            click: () => {
                if (mainWindow) mainWindow.show()
            }
        },
        { label: "exit", click: () => app.quit() }
    ])
    tray.on("click", () => {
        if (mainWindow) mainWindow.show()
    })
    tray.setToolTip("app")
    tray.setContextMenu(contextMenu)

    setMainWindow(mainWindow)
}

// 所有窗口关闭事件
app.on("window-all-closed", () => {
    if (process.platform !== "darwin") {
        app.quit()
    }
})
