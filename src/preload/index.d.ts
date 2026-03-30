import { ElectronAPI } from "@electron-toolkit/preload"
declare global {
    interface Window {
        electron: ElectronAPI
        api: unknown
        ipcRenderer: {
            on: typeof import("electron").ipcRenderer.on
            off: typeof import("electron").ipcRenderer.off
            send: typeof import("electron").ipcRenderer.send
            invoke: typeof import("electron").ipcRenderer.invoke
        }
    }
}
