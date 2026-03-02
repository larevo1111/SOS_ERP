import { boot } from 'quasar/wrappers'
import vue3GoogleLogin from 'vue3-google-login'

export default boot(({ app }) => {
    const clientId = import.meta.env.VITE_GOOGLE_CLIENT_ID || 'PENDIENTE_POR_CONFIGURAR'

    app.use(vue3GoogleLogin, {
        clientId: clientId
    })
})
