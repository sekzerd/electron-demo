import koffi from "koffi"
import path from "path"

function testKoffi(a, b, app) {
    let extra_resource_root = path.resolve(app.getAppPath())
    if (app.isPackaged) {
        // app/resources
        extra_resource_root = path.resolve(extra_resource_root, "extraResources")
    } else {
        // build/extraResources
        extra_resource_root = path.resolve(extra_resource_root, "build/extraResources")
    }
    let dll_root = path.resolve(extra_resource_root, "dlls")
    let demo_dll = koffi.load(dll_root + "/demo_dll.dll")
    console.log("unpacked Resources Root:", dll_root)
    const myadd = demo_dll.func("__stdcall", "myadd", "int", ["int", "int"])
    let ret = myadd(a, b)
    return ret
}

import fs from "fs"
function event_global(ipcMain, app) {
    ipcMain.handle("app:invoke_add", (_event, data) => {
        console.log("invoke_add receive:", data)
        const ret = data + 1
        return Promise.resolve(ret)
    })
    ipcMain.handle("test-koffi", (_event, a, b) => {
        console.log("main test-koffi received")
        console.log("a=", a, "b=", b)
        const ret = testKoffi(a, b, app)
        return Promise.resolve(ret)
    })
    ipcMain.handle("app:fs:writeFileSync", (_event, path, data) => {
        try {
            fs.writeFileSync(path, data)
            return Promise.resolve(null)
        } catch (e) {
            return Promise.resolve(e)
        }
    })
    ipcMain.handle("app:fs:readFileSync", (_event, path, _data) => {
        try {
            const data = fs.readFileSync(path, "utf8")
            return Promise.resolve(data)
        } catch (e) {
            return Promise.resolve(e)
        }
    })
}

export { event_global }
