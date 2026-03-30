<script setup>

</script>
<template>
    <el-popover placement="bottom" trigger="hover" popper-class="appbar-popover">
        <template #reference>
            <div class="svg-icon">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
                    <path
                        d="M16 3C8.832031 3 3 8.832031 3 16C3 23.167969 8.832031 29 16 29C23.167969 29 29 23.167969 29 16C29 8.832031 23.167969 3 16 3 Z M 16 5C22.085938 5 27 9.914063 27 16C27 22.085938 22.085938 27 16 27C9.914063 27 5 22.085938 5 16C5 9.914063 9.914063 5 16 5 Z M 16 8.875L9.59375 15.28125L11 16.71875L15 12.71875L15 23L17 23L17 12.71875L21 16.71875L22.40625 15.28125Z"
                        fill="currentColor" />
                </svg>
            </div>
        </template>
        <template #default>
            <div class="mt-1 mb-1">
                <div v-for="i in ['已是最新版本', '查看历史版本']" class="select-none lang-item">
                    {{ i }}
                </div>
            </div>
        </template>
    </el-popover>
</template>
<style scoped>
.appbar-popover {
    padding: 0 !important;
}

.lang-item {
    transition: all 0.3s ease-in-out;
    padding-left: 0.5rem;
    min-height: 2rem;
    line-height: 2rem;
}

.lang-item:hover {
    background-color: #E5E9F0;
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