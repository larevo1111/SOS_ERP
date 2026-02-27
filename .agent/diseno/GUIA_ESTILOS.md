# Guía de Estilos · ERP Origen Silvestre

> Este archivo es la referencia visual del ERP. Todo agente que toque el frontend debe leerlo antes de generar cualquier componente.
> El archivo `dashboard_ref.html` en esta misma carpeta es el mockup visual de referencia.

---

## 1. Paleta de colores

### Colores base
| Nombre | Hex | Uso |
|---|---|---|
| Negro carbón | `#2C2C28` | Textos principales, logo mark |
| Blanco | `#FFFFFF` | Fondo de cards, sidebar |
| Gris crema | `#F8F7F5` | Fondo principal del contenido |
| Verde salvia transparente | `rgba(141,184,154,0.08)` | Fondo sidebar |
| Borde sidebar | `rgba(141,184,154,0.20)` | Separadores del sidebar |

### Colores de acento (del logo OS)
| Nombre | Hex | Uso |
|---|---|---|
| Naranja OS | `#E8750A` | Botón primario, acento activo, barras de progreso |
| Naranja oscuro | `#C55E00` | Hover de botón primario, textos de valor naranja |
| Naranja transparente | `rgba(232,117,10,0.08)` | Fondo ítem activo sidebar |
| Verde bosque | `#3A7A35` | Estados positivos, éxito, delta positivo |
| Verde salvia | `#8DB89A` | Acento secundario, íconos decorativos |
| Amarillo dorado | `#F0B822` | Gradiente de barras, alertas secundarias |

### Colores semánticos (badges y estados)
| Estado | Fondo | Texto |
|---|---|---|
| Entregado / Éxito | `#E8F5E5` | `#2E7A2A` |
| En proceso / Advertencia | `#FFF0E5` | `#C55E00` |
| Pendiente | `#FEF8E0` | `#9A7200` |
| Borrador / Neutro | `#F3F1EE` | `#7A7A7A` |
| Facturado / Info | `#E5F0FF` | `#1A5ACC` |

### Colores de texto
| Nombre | Hex | Uso |
|---|---|---|
| Texto principal | `#1A1A1A` | Títulos, valores KPI |
| Texto secundario | `#3A3A3A` | Contenido general |
| Texto terciario | `#6A6A6A` | Subtítulos, descripciones |
| Texto muted | `#7A7A7A` | Labels de KPI, etiquetas |
| Texto placeholder | `#AAAAAA` | Textos de apoyo, timestamps |

---

## 2. Tipografía

**Fuente:** `'Segoe UI', system-ui, -apple-system, sans-serif`
Sin fuente externa por ahora. Cuando el proyecto escale se evaluará Inter o Plus Jakarta Sans.

| Elemento | Tamaño | Peso | Color |
|---|---|---|---|
| Título de página (h1) | `22px` | `800` | `#1A1A1A` |
| Subtítulo de página | `13px` | `400` | `#6A6A6A` |
| Título de card | `13px` | `700` | `#1A1A1A` |
| Valor KPI | `28px` | `800` | `#1A1A1A` |
| Label KPI | `11px` | `600` | `#7A7A7A` |
| Delta KPI | `12px` | `600` | semántico |
| Ítem sidebar | `13px` | `500` | `#3A3A3A` |
| Ítem sidebar activo | `13px` | `600` | `#C55E00` |
| Label de sección sidebar | `9.5px` | `700` | `#AAAAAA` |
| Texto de tabla | `12px` | `500` | `#2A2A2A` |
| Badge | `10px` | `700` | semántico |
| Timestamp | `11px` | `400` | `#AAAAAA` |

---

## 3. Espaciado y layout

**Ancho del sidebar:** `230px`
**Padding del contenido principal:** `28px 30px`
**Gap entre cards:** `14px`
**Padding interno de card:** `20px`

### Grid del dashboard
```
KPIs:      4 columnas iguales
Fila 2:    1.1fr  0.9fr
Fila 3:    1fr  1fr  0.7fr
```

---

## 4. Componentes

### Card
```
background:    #FFFFFF
border-radius: 16px
padding:       20px
border:        1px solid rgba(0,0,0,0.04)
box-shadow:    0 1px 3px rgba(0,0,0,0.06), 0 4px 16px rgba(0,0,0,0.04)
```

### Botón primario
```
background:    #E8750A
color:         #FFFFFF
border-radius: 10px
padding:       9px 18px
font-size:     12px
font-weight:   600
box-shadow:    0 4px 14px rgba(232,117,10,0.28)
hover:         background #C55E00
```

### Botón outline
```
background:    #FFFFFF
color:         #3A3A3A
border:        1px solid #E0DDD8
border-radius: 10px
padding:       9px 18px
font-size:     12px
font-weight:   600
```

### Botón ícono
```
width/height:  38px
background:    #FFFFFF
border:        1px solid #E0DDD8
border-radius: 10px
```

### Badge
```
font-size:     10px
font-weight:   700
padding:       3px 9px
border-radius: 20px
colores:       ver tabla de colores semánticos
```

### Ítem activo en sidebar
```
background:    rgba(232,117,10,0.08)
color:         #C55E00
font-weight:   600
border-radius: 10px
indicador:     línea izquierda 3px solid #E8750A
```

### Badge de notificación en sidebar
```
background:    #E8750A
color:         #FFFFFF
font-size:     9px
font-weight:   700
padding:       2px 6px
border-radius: 10px
```

### KPI card
```
border-radius: 16px
padding:       20px
ícono:         40x40px, border-radius 12px, fondo semántico suave
valor:         28px, peso 800
label:         11px, uppercase, letter-spacing 0.4px
```

### Ícono de KPI (fondos suaves)
```
Ventas:     #FFF0E5  (naranja suave)
Órdenes:    #E8F5E5  (verde suave)
Stock:      #FEF8E0  (amarillo suave)
Clientes:   #F0EDE8  (crema)
```

### Barra de progreso
```
height:        5px
background:    #F0EDE8  (vacía)
border-radius: 3px
fill:          linear-gradient(90deg, #E8750A, #F0B822)
```

### Separadores de tabla
```
border-bottom: 1px solid #F3F1EE
padding:       9px 0
última fila:   sin borde
```

### Punto de actividad
```
width/height:  8px
border-radius: 50%
colores:       verde #3A7A35, naranja #E8750A, amarillo #F0B822, verde salvia #8DB89A, azul #1A5ACC
```

---

## 5. Sidebar

```
width:         230px
background:    rgba(141,184,154,0.08)
border-right:  1px solid rgba(141,184,154,0.20)
```

**Logo mark:**
```
width/height:  38px
background:    #2C2C28
border-radius: 11px
```

**Usuario (footer):**
```
avatar:        34px, circular, background #2C3D2E, texto #8DB89A
```

---

## 6. Reglas de diseño que nunca se rompen

- Nunca usar dark mode. El ERP es siempre claro.
- Nunca texto gris claro sobre fondo gris. Mínimo contraste `#6A6A6A` sobre blanco.
- Los KPIs siempre tienen ícono con fondo de color suave, nunca ícono solo.
- Los badges siempre usan la tabla de colores semánticos. No inventar colores nuevos.
- Las cards nunca tienen borde de color, solo sombra suave y borde `rgba(0,0,0,0.04)`.
- El naranja `#E8750A` es el único acento fuerte. No usar dos acentos fuertes en la misma vista.
- Todo texto de datos importantes (valores, nombres) mínimo `#2A2A2A`.
- Espaciado generoso: mejor respirar que comprimir.

---

## 7. Referencia visual

El archivo `dashboard_ref.html` en esta misma carpeta es el mockup completo del dashboard. Cualquier duda de cómo debe verse un componente, consultarlo ahí primero.
