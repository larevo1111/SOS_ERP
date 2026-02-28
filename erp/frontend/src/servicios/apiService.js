// erp/frontend/src/servicios/apiService.js
//
// Centraliza todas las llamadas HTTP a la API del ERP.
// Toda petición sigue el protocolo del Manifiesto § 5.2 y § 5.3:
//   → POST con { token, accion, datos }
//   ← { exito, datos, mensaje, errores }
//
// Variables requeridas en erp/frontend/.env:
//   VITE_API_URL   → URL base (ej: http://localhost/erp/api o https://erp.oscomunidad.com/api)
//   VITE_API_TOKEN → Token secreto. Debe coincidir con R2_TOKEN en el .env del servidor.

const URL_BASE = import.meta.env.VITE_API_URL   || '/erp/api'
const TOKEN    = import.meta.env.VITE_API_TOKEN  || ''

// ── Llamada JSON estándar ─────────────────────────────────────────
// Usar para: guardar_producto, obtener_producto, etc.
// Lanza Error si exito=false para que el catch del componente lo maneje.
async function llamar (modulo, area, accion, datos = {}) {
  const url = `${URL_BASE}/${modulo}/${area}`

  let respuesta
  try {
    respuesta = await fetch(url, {
      method:  'POST',
      headers: { 'Content-Type': 'application/json; charset=utf-8' },
      body:    JSON.stringify({ token: TOKEN, accion, datos }),
    })
  } catch {
    throw new Error('Sin conexión con el servidor. Verifica tu red.')
  }

  const json = await respuesta.json().catch(() => {
    throw new Error(`El servidor respondió algo inesperado (HTTP ${respuesta.status}).`)
  })

  if (!json.exito) {
    const detalles = json.errores?.length ? ` — ${json.errores.join(', ')}` : ''
    throw new Error((json.mensaje || 'Error en la API') + detalles)
  }

  return json.datos
}

// ── Subida de archivos (multipart/form-data) ──────────────────────
// Usar para: subir_multimedia.
// Los datos extra van como campo JSON 'datos'; el archivo como 'archivo'.
// IMPORTANTE: No poner Content-Type en los headers — el navegador lo
// agrega automáticamente con el boundary correcto para el multipart.
async function subirArchivo (modulo, area, accion, archivo, datosExtra = {}) {
  const url = `${URL_BASE}/${modulo}/${area}`

  const formulario = new FormData()
  formulario.append('token',  TOKEN)
  formulario.append('accion', accion)
  formulario.append('datos',  JSON.stringify(datosExtra))
  formulario.append('archivo', archivo, archivo.name)

  let respuesta
  try {
    respuesta = await fetch(url, { method: 'POST', body: formulario })
  } catch {
    throw new Error('Sin conexión con el servidor. Verifica tu red.')
  }

  const json = await respuesta.json().catch(() => {
    throw new Error(`El servidor respondió algo inesperado (HTTP ${respuesta.status}).`)
  })

  if (!json.exito) {
    const detalles = json.errores?.length ? ` — ${json.errores.join(', ')}` : ''
    throw new Error((json.mensaje || 'Error al subir el archivo') + detalles)
  }

  return json.datos
}

export { llamar, subirArchivo }
