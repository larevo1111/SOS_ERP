# skill_acceso_datos_php.md

## Para qué sirve
Este skill explica cómo interactuar con MariaDB desde el código PHP del ERP, asegurando una conexión robusta y el cumplimiento de las leyes de base de datos del Manifiesto. Es una guía de **Desarrollo/Código**.

## Reglas que nunca se rompen
1. **Clase Única**: Siempre usar `Infraestructura\BaseDatos\Conexion::obtenerInstancia()`. Nunca crear nuevas instancias de `PDO` manualmente.
2. **Variables de Entorno**: El código nunca debe conocer las contraseñas reales. Todo fluye por el `.env` vía `getenv()`.
3. **Modo Errores**: La conexión siempre debe estar configurada con `PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION`.

## Problemas conocidos y soluciones
- **Error `ATTR_ERRMODE`**: Ojo con el typo común `ATTR_ERR_MODE` (incorrecto).
- **Campos NOT NULL sin Default (Error 1364)**: Si una tabla heredada exige un valor (como `url_producto`), el desarrollador debe asegurarse de enviarlo en el `INSERT` o pedirle a Santi estandarizar la tabla con un `DEFAULT` si aplica.
- **Rutas en Scripts Temporales**: Al ejecutar scripts desde la consola, asegurarse de usar rutas absolutas para los `require_once`.

## Ejemplos de código correcto
Conexión y consulta preparada:
```php
require_once __DIR__ . '/erp/infraestructura/base_datos/Conexion.php';
$db = Infraestructura\BaseDatos\Conexion::obtenerInstancia();
$stmt = $db->prepare("SELECT * FROM com_productos WHERE uid = :uid");
$stmt->execute([':uid' => $uid]);
$producto = $stmt->fetch();
```
