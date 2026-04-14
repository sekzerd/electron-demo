import { createMemoryHistory, createRouter } from "vue-router"

const routes = [
    { path: "/", name: "HomePage", component: () => import("@renderer/pages/Home.vue") },
]

export const router = createRouter({
    history: createMemoryHistory(),
    routes
})
