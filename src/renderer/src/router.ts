import { createMemoryHistory, createRouter } from "vue-router"

import HomePage from "./pages/Home.vue"
const routes = [
    { path: "/", name: "HomePage", component: () => import("./pages/Home.vue") },


]

export const router = createRouter({
    history: createMemoryHistory(),
    routes
})
