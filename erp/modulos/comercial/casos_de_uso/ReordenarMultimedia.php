<?php
// erp/modulos/comercial/casos_de_uso/ReordenarMultimedia.php

class ReordenarMultimedia
{
    private PDO $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function ejecutar(array $datos): array
    {
        $lista = $datos['lista'] ?? [];
        $empresa = trim($datos['empresa'] ?? '');
        $usuario = trim($datos['usuario_ult_modificacion'] ?? 'sistema');

        if (empty($lista) || !is_array($lista) || $empresa === '') {
            return $this->respuesta(false, null, 'Lista de IDs o empresa faltante.', ['parametros_invalidos']);
        }

        try {
            $this->pdo->beginTransaction();

            $sql = "UPDATE com_productos_multimedia 
                    SET orden = :orden, usuario_ult_modificacion = :usuario 
                    WHERE uid = :uid AND empresa = :empresa";
            $stmt = $this->pdo->prepare($sql);

            foreach ($lista as $index => $uid) {
                // $index + 1 garantiza que el orden comience en 1
                $ordenNuevo = $index + 1;
                $stmt->execute([
                    ':orden' => $ordenNuevo,
                    ':usuario' => $usuario,
                    ':uid' => $uid,
                    ':empresa' => $empresa
                ]);
            }

            $this->pdo->commit();
            return $this->respuesta(true, null, 'Galería reordenada correctamente.');

        }
        catch (Exception $e) {
            $this->pdo->rollBack();
            return $this->respuesta(false, null, 'Error al reordenar: ' . $e->getMessage(), ['error_mysql']);
        }
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