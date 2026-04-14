import { createMemoryHistory, createRouter } from "vue-router"

import HomePage from "@renderer/pages/Home.vue"
const routes = [
    { path: "/", name: "HomePage", component: () => import("@renderer/pages/Home.vue") },


]

export const router = createRouter({
    history: createMemoryHistory(),
    routes
})
