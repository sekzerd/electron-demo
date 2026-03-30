<script setup>
function on_close() {
    window.ipcRenderer.send("win:hide", {});
}
</script>
<template>
    <el-tooltip content="Bottom center" placement="bottom" effect="light">
        <template #default>
            <div class="svg-icon" @click.stop="on_close()">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
                    <path
                        d="M16 4C9.3844239 4 4 9.3844287 4 16C4 22.615571 9.3844239 28 16 28C22.615576 28 28 22.615571 28 16C28 9.3844287 22.615576 4 16 4 z M 16 6C21.534697 6 26 10.465307 26 16C26 21.534693 21.534697 26 16 26C10.465303 26 6 21.534693 6 16C6 10.465307 10.465303 6 16 6 z M 12.707031 11.292969L11.292969 12.707031L14.585938 16L11.292969 19.292969L12.707031 20.707031L16 17.414062L19.292969 20.707031L20.707031 19.292969L17.414062 16L20.707031 12.707031L19.292969 11.292969L16 14.585938L12.707031 11.292969 z"
                        fill="currentColor" />
                </svg>
            </div>
        </template>
        <template #content>
            <div class="h-8 flex justify-center items-center select-none">
                关闭
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