let mainWindow = null

export function useMainWindow(){
    const setMainWindow = (_win) => {
    mainWindow = _win
    }
    return {
        mainWindow,
        setMainWindow
    }
}