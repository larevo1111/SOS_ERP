import { defineStore } from 'pinia'
import { llamar } from 'src/servicios/apiService'

export const useAuthStore = defineStore('auth', {
    state: () => ({
        token: localStorage.getItem('jwt_token') || null,
        usuario: JSON.parse(localStorage.getItem('jwt_usuario') || 'null'),
        empresas: JSON.parse(localStorage.getItem('jwt_empresas') || '[]'),
        // Token temporal cuando se requiere seleccionar empresa
        tokenTemporal: null,
        empresasDisponiblesTemp: []
    }),

    getters: {
        estaAutenticado: (state) => !!state.token,
        empresaActiva: (state) => state.usuario?.empresa_activa || null,
        nombreEmpresaActiva: (state) => state.usuario?.empresa_nombre || 'Sin Empresa',
        siglasEmpresaActiva: (state) => state.usuario?.empresa_siglas || ''
    },

    actions: {
        // Iniciar el flujo con Google OAuth
        async autenticarGoogle(idToken) {
            try {
                const payload = await llamar('sistema', 'login', 'autenticar_google', { id_token: idToken })
                return this.procesarRespuestaAuth(payload)
            } catch (error) {
                throw error
            }
        },

        // Iniciar flujo con Correo
        async autenticarCorreo(correo, contrasena) {
            try {
                const payload = await llamar('sistema', 'login', 'autenticar_correo', { correo, contrasena })
                return this.procesarRespuestaAuth(payload)
            } catch (error) {
                throw error
            }
        },

        // Si el usuario tiene múltiples empresas, el backend devuelve un token temporal
        procesarRespuestaAuth(payload) {
            if (payload.requiere_seleccion) {
                this.tokenTemporal = payload.token_temporal
                this.empresasDisponiblesTemp = payload.empresas
                return { requiereMapeo: true, empresas: payload.empresas }
            }

            // Si por alguna razón el backend enviara el definitivo de una vez (aunque siempre obliga)
            this.establecerSesion(payload.token, payload.usuario, payload.empresas_disponibles)
            return { requiereMapeo: false }
        },

        // Paso 2: Seleccionar empresa con el token temporal → JWT definitivo
        async seleccionarEmpresa(uidEmpresa) {
            try {
                const payload = await llamar('sistema', 'login', 'seleccionar_empresa', {
                    token_temporal: this.tokenTemporal,
                    empresa: uidEmpresa      // uid de sys_empresa (ej: 'Ori_Sil_2')
                })
                this.tokenTemporal = null
                this.empresasDisponiblesTemp = []
                // payload.token y payload.usuario vienen del backend (ver AuthController)
                this.establecerSesion(payload.token, payload.usuario, payload.empresas_disponibles || [])
                return true
            } catch (error) {
                throw error
            }
        },

        // Cambiar de empresa estando ya logueado (solicita nuevo JWT)
        // El backend puede implementarlo usando auth/seleccionar-empresa enviando el JWT actual en vez del temporal
        // o podemos simplemente desloguear si no está soportado.

        // Guardar sesión final
        establecerSesion(token, usuario, empresas) {
            this.token = token
            this.usuario = usuario
            this.empresas = empresas

            localStorage.setItem('jwt_token', token)
            localStorage.setItem('jwt_usuario', JSON.stringify(usuario))
            localStorage.setItem('jwt_empresas', JSON.stringify(empresas))
        },

        // Cerrar sesión
        cerrarSesion() {
            this.token = null
            this.usuario = null
            this.empresas = []
            this.tokenTemporal = null
            this.empresasDisponiblesTemp = []

            localStorage.removeItem('jwt_token')
            localStorage.removeItem('jwt_usuario')
            localStorage.removeItem('jwt_empresas')
        }
    }
})
