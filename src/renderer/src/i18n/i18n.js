import { createI18n } from "vue-i18n"
import en_US from "./en_US.json"
import zh_CN from "./zh_CN.json"

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
