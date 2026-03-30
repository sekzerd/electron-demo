// import { AzCustomWindowMove } from "../utils/utils"
import { APP_HEIGHT, APP_WIDTH } from "../config"
function event_window(ipcMain, win) {
    ipcMain.on("win:minimize", (_data) => {
        win.minimize()
    })
    ipcMain.on("win:hide", (_data) => {
        win.hide()
    })
    ipcMain.on("win:cropsquare", (_data) => {
        let wh = win.getSize()
        if (Math.abs(wh[0] - APP_WIDTH) <= 2 && Math.abs(wh[1] - APP_HEIGHT) <= 2) {
            win.maximize()
        } else {
            win.unmaximize()
            win.setSize(APP_WIDTH, APP_HEIGHT)
        }
    })
    ipcMain.on("win:close", (_data) => {
        win.close()
        win.destroy()
    })
}

export { event_window }
