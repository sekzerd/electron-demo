<script setup lang="ts">
// import Versions from './components/Versions.vue'
import AppBar from "@renderer/components/AppBar.vue"
const onHome = ()=>{
   window.ipcRenderer.send('control')}
</script>

<template>
    <div class="select-none h-screen flex flex-col">
        <AppBar  class="h-16"/>
        <div class="flex justify-center items-center flex-1 font-bold text-[2rem]" @click="onHome">home</div>
    </div>
</template>
