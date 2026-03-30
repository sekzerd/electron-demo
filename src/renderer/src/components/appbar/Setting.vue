<script setup>
import { useRouter } from 'vue-router'
const router = useRouter()

const on_settings = () => {
    // router.push('/app/settings')
}
</script>
<template>
    <el-tooltip content="Bottom center" placement="bottom" effect="light">
        <template #default>
            <div class="svg-icon" @click="on_settings()">
                <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px"
                    y="0px" viewBox="0 0 64 64" style="enable-background:new 0 0 64 64;" xml:space="preserve">
                    <path fill="currentColor" d="M30.2,7.8l-18.5,11c-1.1,0.6-1.7,1.8-1.7,3v22.1c0,0.7,0.4,1.4,1,1.8h0l19.2,10.6c1.1,0.6,2.4,0.6,3.5-0.1
	l18.5-11c1.1-0.6,1.7-1.8,1.7-3V21c0-1.3-0.7-2.4-1.8-3.1L33.7,7.7C32.6,7.1,31.3,7.1,30.2,7.8z M33.8,12.3l14.4,7.9
	c1.1,0.6,1.8,1.8,1.8,3.1v16.6c0,1.2-0.6,2.4-1.7,3l-14.6,8.7c-1.1,0.6-2.4,0.7-3.5,0.1l-14.4-7.9c-1.1-0.6-1.8-1.8-1.8-3.1V24.1
	c0-1.2,0.6-2.4,1.7-3l14.6-8.7C31.4,11.8,32.7,11.7,33.8,12.3z M33.6,20.1c-4.6-0.5-8.3,1.1-10.6,3.7c-2,2.3-3,5.3-3,8.2
	s1,5.9,3,8.2s5.2,3.8,9,3.8c8.3,0,14.6-8.5,10.9-17.1C41.3,23.1,37.7,20.5,33.6,20.1z M32,24c4.6,0,8.2,3.8,8,8.4
	c-0.3,5.1-5.4,8.5-10.3,7.3c-1.6-0.4-2.8-1.2-3.7-2.2c-1.3-1.5-2-3.5-2-5.5s0.7-4.1,2-5.5C27.3,25,29.2,24,32,24z" />
                </svg>
            </div>
        </template>
        <template #content>
            <div class="h-8 flex justify-center items-center select-none">
                设置
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