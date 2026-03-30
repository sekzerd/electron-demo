<script setup>
function on_cropsquare() {
    window.ipcRenderer.send("win:cropsquare", {});
}
</script>
<template>
    <el-tooltip content="Bottom center" placement="bottom" effect="light">
        <template #default>
            <div class="svg-icon" @click.stop="on_close()">
                <div class="svg-icon" @click.stop="on_cropsquare()">
                    <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                        x="0px" y="0px" viewBox="0 0 64 64" style="enable-background:new 0 0 64 64;"
                        xml:space="preserve">
                        <path fill="currentColor" d="M18.5,12c-4.3,0-7.7,4.5-7.7,10v20c0,5.5,3.5,10,7.7,10h24.8c4.3,0,7.7-4.5,7.7-10V22c0-5.5-3.5-10-7.7-10H18.5
	z M18.9,16h24c2.5,0,4.5,2.7,4.5,6v20c0,3.3-2,6-4.5,6h-24c-2.5,0-4.5-2.7-4.5-6V22C14.4,18.7,16.4,16,18.9,16z" />
                    </svg>
                </div>
            </div>
        </template>
        <template #content>
            <div class="h-8 flex justify-center items-center select-none">
                最大化
            </div>
        </template>
    </el-tooltip>
</template>
<style scoped>
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