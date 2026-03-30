<script setup>
function on_minimize() {
    window.ipcRenderer.send("win:minimize", {});
}
</script>
<template>
    <el-tooltip content="Bottom center" placement="bottom" effect="light">
        <template #default>
            <div class="svg-icon" @click.stop="on_minimize()">
                <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px"
                    y="0px" viewBox="0 0 64 64" style="enable-background:new 0 0 64 64;" xml:space="preserve">
                    <path fill="currentColor" d="M5.6,30.6v2.8c0,0.3,0.2,0.6,0.5,0.6H59c0.3,0,0.5-0.3,0.5-0.6v-2.8c0-0.3-0.2-0.6-0.5-0.6H6.2
	C5.9,30,5.6,30.3,5.6,30.6z" />
                </svg>
            </div>
        </template>
        <template #content>
            <div class="h-8 flex justify-center items-center select-none">
                最小化
            </div>
        </template>
    </el-tooltip>
</template>
<style scoped>
.appbar-popover {
    padding: 0 !important;
}

.svg-icon {
    height: 2rem;
    width: 2rem;
    transition: all 0.1s ease-in-out;
    color: #5b5b5b;
}

.svg-icon:hover {
    color: #0046f8;
}
</style>