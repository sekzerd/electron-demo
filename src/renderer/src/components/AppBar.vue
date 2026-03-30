<script setup lang="ts">
function on_mouse_down() {
    // window.ipcRenderer.send("win:drag_start", {})
}
function on_mouse_up() {
    // window.ipcRenderer.send("win:drag_end", {})
}

import Language from './appbar/Language.vue'
import Update from './appbar/Update.vue'
import Setting from './appbar/Setting.vue'
import Minimize from './appbar/Minimize.vue'
import Cropsquare from './appbar/Cropsquare.vue'
import Close from './appbar/Close.vue'

import { enableWindowDrag, disableWindowDrag } from 'electron-drag-plus/renderer';
import { onMounted } from 'vue'

onMounted(() => {
    enableWindowDrag('#title-bar');
    disableWindowDrag('#menu-bar');
})

</script>

<template>
    <div class="flex bg-[#F2F3F7] w-full place-content-between" id="title-bar" v-on:mouseup="on_mouse_up()"
        v-on:mousedown="on_mouse_down()">
        <div class="flex justify-center items-center w-40">
            <div class="text-[1.5rem] ml-8 font-bold">App</div>
        </div>
        <div class="flex items-center justify-end gap-7 mr-8" id="menu-bar">
            <Language />
            <Update />
            <Setting />
            <Minimize />
            <Cropsquare />
            <Close />
        </div>
    </div>
</template>
<style>
.appbar-popover {
    padding: 0 !important;
}
</style>