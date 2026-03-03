<?php
// erp/modulos/comercial/casos_de_uso/CambiarUsoMultimedia.php

class CambiarUsoMultimedia
{
    private PDO $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function ejecutar(array $datos): array
    {
        $uid = trim($datos['uid'] ?? '');
        $uso = trim($datos['uso'] ?? '');
        $empresa = trim($datos['empresa'] ?? '');
        $usuario = trim($datos['usuario_ult_modificacion'] ?? 'sistema');

        if ($uid === '' || $uso === '' || $empresa === '') {
            return $this->respuesta(false, null, 'Parametros (uid, uso, empresa) son obligatorios.', ['parametros_invalidos']);
        }

        // Valores de uso permitidos según ENUM
        $usosValidos = ['Principal', 'Galeria', 'Variacion', 'Galeria secundaria', 'Otro'];
        if (!in_array($uso, $usosValidos)) {
            return $this->respuesta(false, null, 'El valor de uso es inválido.', ['uso_invalido']);
        }

        $sql = "UPDATE com_productos_multimedia 
                SET uso = :uso, usuario_ult_modificacion = :usuario 
                WHERE uid = :uid AND empresa = :empresa";

        $stmt = $this->pdo->prepare($sql);
        $exito = $stmt->execute([
            ':uso' => $uso,
            ':usuario' => $usuario,
            ':uid' => $uid,
            ':empresa' => $empresa
        ]);

        return $this->respuesta($exito, null, 'Uso actualizado correctamente.');
    }

    private function respuesta(bool $exito, $datos, string $mensaje, array $errores = []): array
    {
        return [
            'exito' => $exito,
            'datos' => $datos ?? (object)[],
            'mensaje' => $mensaje,
            'errores' => $errores,
        ];
    }
}