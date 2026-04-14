import { createI18n } from "vue-i18n"
import en_US from "@renderer/i18n/en_US.json"
import zh_CN from "@renderer/i18n/zh_CN.json"

export let i18n = createI18n({
    locale: "zh-cn",
    fallbackLocale: "zh-cn",
    globalInjection: true,
    silentTranslationWarn: true,
    messages: {
        "en-us": en_US,
        "zh-cn": zh_CN
    }
})
