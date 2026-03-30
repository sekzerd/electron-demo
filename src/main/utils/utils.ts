import { screen } from "electron"

class AzCustomWindowMove {
    isOpen: boolean
    win: any
    winStartPosition: {
        x: number
        y: number
        width: number
        height: number
    }
    startPosition: {
        x: number
        y: number
    }
    constructor() {
        this.isOpen = false
        this.win = null
        this.winStartPosition = {
            x: 0,
            y: 0,
            width: 0,
            height: 0
        }
        this.startPosition = {
            x: 0,
            y: 0
        }
    }
    init(win: any) {
        this.win = win
    }
    start() {
        this.isOpen = true
        const winPosition = this.win.getPosition()
        const winSize = this.win.getSize()
        this.winStartPosition.x = winPosition[0]
        this.winStartPosition.y = winPosition[1]
        this.winStartPosition.width = winSize[0]
        this.winStartPosition.height = winSize[1]
        const mouseStartPosition = screen.getCursorScreenPoint()
        this.startPosition.x = mouseStartPosition.x
        this.startPosition.y = mouseStartPosition.y
        this.move()
    }
    move() {
        if (!this.isOpen) {
            return
        }
        if (this.win.isDestroyed()) {
            this.end()
            return
        }
        if (!this.win.isFocused()) {
            this.end()
            return
        }
        const cursorPosition = screen.getCursorScreenPoint()
        const x = this.winStartPosition.x + cursorPosition.x - this.startPosition.x
        const y = this.winStartPosition.y + cursorPosition.y - this.startPosition.y
        this.win.setBounds({
            x: x,
            y: y,
            width: Math.floor(this.winStartPosition.width),
            height: Math.floor(this.winStartPosition.height)
        })
        setTimeout(() => {
            this.move()
        }, 0)
    }
    end() {
        this.isOpen = false
    }
}

const safeDOM = {
    append(parent: HTMLElement, child: HTMLElement) {
        if (!Array.from(parent.children).find((e) => e === child)) {
            return parent.appendChild(child)
        }
        return null
    },
    remove(parent: HTMLElement, child: HTMLElement) {
        if (Array.from(parent.children).find((e) => e === child)) {
            return parent.removeChild(child)
        }
        return null
    }
}
function useLoading() {
    const className = `loaders-css__square-spin`
    const styleContent = `
@keyframes square-spin {
25% { transform: perspective(100px) rotateX(180deg) rotateY(0); }
50% { transform: perspective(100px) rotateX(180deg) rotateY(180deg); }
75% { transform: perspective(100px) rotateX(0) rotateY(180deg); }
100% { transform: perspective(100px) rotateX(0) rotateY(0); }
}
.${className} > div {
animation-fill-mode: both;
width: 50px;
height: 50px;
background: #fff;
animation: square-spin 3s 0s cubic-bezier(0.09, 0.57, 0.49, 0.9) infinite;
}
.app-loading-wrap {
position: fixed;
top: 0;
left: 0;
width: 100vw;
height: 100vh;
display: flex;
align-items: center;
justify-content: center;
background: #282c34;
z-index: 9;
}
  `
    const oStyle = document.createElement("style")
    const oDiv = document.createElement("div")

    oStyle.id = "app-loading-style"
    oStyle.innerHTML = styleContent
    oDiv.className = "app-loading-wrap"
    oDiv.innerHTML = `<div class="${className}"><div></div></div>`

    return {
        appendLoading() {
            safeDOM.append(document.head, oStyle)
            safeDOM.append(document.body, oDiv)
        },
        removeLoading() {
            safeDOM.remove(document.head, oStyle)
            safeDOM.remove(document.body, oDiv)
        }
    }
}

export { AzCustomWindowMove, useLoading }
import { app } from "electron"
import path from "path"
export function getResource(){
    let resource_root = path.resolve(app.getAppPath())
    // if (app.isPackaged) {
    //     resource_root = path.resolve(resource_root, "extraResources")
    // } else {
    //     resource_root = path.resolve(resource_root, "build/extraResources")
    // }
    return resource_root
}