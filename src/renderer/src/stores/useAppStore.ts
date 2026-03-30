// stores/counter.js
import { defineStore } from "pinia"

export const useAppStore = defineStore("App", {
    state: () => {
        return { text: "" }
    },
    // could also be defined as
    // state: () => ({ count: 0 })
    actions: {},
    persist: true
})
