// import './assets/main.css'
import "./assets/tailwind.css"
import "./assets/theme.css"
import { createApp } from "vue"
import App from "./App.vue"
import { createPinia } from "pinia"
import ElementPlus from "element-plus"
import { router } from "./router"
const pinia = createPinia()

import piniaPluginPersistedstate from "pinia-plugin-persistedstate"
pinia.use(piniaPluginPersistedstate)
const app = createApp(App)
app.use(pinia)
app.use(ElementPlus)
app.use(router)

app.mount("#app")
