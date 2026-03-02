---
description: Guía inmutable para el manejo, subida y estructuración de archivos multimedia (Cloudflare R2) en el ERP. LEER COMPLETO antes de tocar cualquier código de subida de archivos.
---

# 📸 Política de Archivos y Multimedia (CDN / R2)

## 0. Principio Fundamental — Analiza la BD ANTES de Codificar

⚠️ **OBLIGATORIO**: Antes de escribir cualquier INSERT, UPDATE o SELECT relacionado con multimedia, ejecuta:
```bash
mysql -u[user] -p[pass] [db] -e "DESCRIBE com_productos_multimedia;"
```
No asumas columnas. El schema real manda. Si el schema en código no coincide con la BD, el código está MAL.

## 1. Filosofía de Almacenamiento (PRINCIPIO INAMOVIBLE)

**El campo `archivo_local` almacena SOLO la ruta relativa dentro del bucket, SIN la URL base del proveedor.**

```
BD guarda:   empresas/ori_sil_2/productos/OS.260302101558/20260302-a1b2.jpg
NO guarda:   https://archivos.oscomunidad.com/empresas/ori_sil_2/...
```

La URL completa se reconstruye en tiempo de ejecución:
```php
$urlCompleta = rtrim(getenv('R2_URL_PUBLICA'), '/') . '/' . $registro['archivo_local'];
```

**¿Por qué?** Porque si mañana cambias de Cloudflare R2 a AWS S3 o Hostinger Storage, solo cambias la variable de entorno `R2_URL_PUBLICA`. La BD no se toca. Sin este principio, tendrías que hacer UPDATE masivo en miles de registros.

## 2. Schema Real de com_productos_multimedia (Verificado 2026-03-02)

> ⚠️ CRÍTICO: Usar SIEMPRE estos nombres. Verificar con DESCRIBE antes de INSERT.

| Columna | Tipo | Qué guarda |
|---|---|---|
| `uid` | VARCHAR(80) | Formato `SIGLAS.YYMMDDHHMMSS` |
| `uid_producto` | VARCHAR(80) | FK → `com_productos.uid` (ON DELETE CASCADE) |
| `tipo_archivo` | ENUM(`imagen,video,documento,html`) | Auto-detectado del MIME type |
| `uso` | ENUM(`Principal,Galeria,Variacion,Galeria secundaria,Otro`) | Definido por sección de la UI |
| `archivo_local` | VARCHAR(500) | **Ruta relativa en el bucket** (sin URL base) |
| `archivo_woocommerce` | VARCHAR(500) | ID de WooCommerce (vacío hasta sincronización) |
| `orden` | INT DEFAULT 0 | Orden de visualización |
| `estado` | ENUM(`Activo,Inactivo`) | Estado |
| + campos de auditoría estándar | | empresa, usuario_creador, etc. |

### Mapa de `uso` según sección de la UI:
| Sección de la UI | Valor de `uso` |
|---|---|
| Pestaña General → foto principal | `Principal` |
| Popup de Variaciones → imagen de variación | `Variacion` |
| Pestaña Galería → sección principal | `Galeria` |
| Pestaña Galería → sección secundaria | `Galeria secundaria` |
| Reservado para uso futuro | `Otro` |

## 3. Relación Padre-Hijo en BD

La tabla `com_productos_multimedia` tiene FK formal con CASCADE:
```sql
FOREIGN KEY (uid_producto) REFERENCES com_productos(uid) ON DELETE CASCADE ON UPDATE CASCADE
```
- Si se borra un producto → sus multimedia se borran automáticamente en BD
- ⚠️ El código PHP que borra un producto DEBE también eliminar los archivos físicos en R2 (la FK limpia la BD, pero no el bucket)

## 4. INSERT Correcto (template)

```php
// ✅ CORRECTO
$stmt->execute([
    ':uid'                      => $uid,                  // SIGLAS.YYMMDDHHMMSS
    ':empresa'                  => $empresa,               // strtolower
    ':uid_producto'             => $uidProducto,           // uid del com_productos padre
    ':tipo_archivo'             => $tipoArchivo,           // 'imagen' | 'video' | etc.
    ':archivo_local'            => $rutaEnBucket,          // ruta relativa en el bucket
    ':archivo_woocommerce'      => '',                     // vacío hasta sincronizar con WC
    ':uso'                      => $datos['uso'] ?? 'Galeria',
    ':orden'                    => $orden,
    ':estado'                   => 'Activo',
    ':usuario_creador'          => $usuario,
    ':usuario_ult_modificacion' => $usuario,
]);
```

## 5. Protocolo de Carga Frontend-Backend

### 5.1 Restricción de "Registro Previo" (Frontend)
**CRÍTICO:** Nunca permitas subir archivos si el registro padre (producto) no ha sido guardado (no tiene `uid`).
```javascript
if (!producto.value.uid) {
  $q.notify({ type: 'warning', message: 'Guarda el producto primero para adjuntar archivos.' })
  return
}
```

### 5.2 Envío `multipart/form-data` con API Service
No usar JSON estándar. Usar `subirArchivo()` de `apiService.js`.

El campo `uso` va dentro de `datos`:
```javascript
await subirArchivo('comercial', 'productos', 'subir_multimedia', archivoFisico, {
  uid_producto: producto.value.uid,
  uso: 'Galeria'  // 'Principal' | 'Galeria' | 'Variacion' | 'Galeria secundaria'
})
```

### 5.3 Construcción de URL para mostrar imágenes en Frontend
```javascript
// El backend devuelve 'archivo_local' (ruta relativa) y 'url_publica_calculada' (URL completa)
const urlImagen = archivo.url_publica_calculada || archivo.archivo_woocommerce || ''
```

## 6. Problemas Conocidos y Soluciones

- **`Data truncated for column 'uso'`**: El frontend envió `'Portada'` que no existe en el ENUM. El valor correcto es `'Principal'`. Revisar `opcionesUso` en los Vue de formularios.
- **`Unknown column 'nombre_archivo' in INSERT INTO`**: Las columnas reales son `archivo_local` y `archivo_woocommerce`. Los nombres `nombre_archivo`, `ruta_archivo`, `url_publica` NO existen en la BD.
- **Archivos huérfanos en R2**: Ocurren cuando el PHP crea el archivo en R2 pero el INSERT falla. Solución: el PHP debe intentar eliminar el archivo de R2 si el INSERT falla (try-catch).
- **Error de FK al insertar multimedia**: Ocurre cuando `uid_producto` no existe en `com_productos`. Verificar que el producto se guardó antes de subir multimedia.
