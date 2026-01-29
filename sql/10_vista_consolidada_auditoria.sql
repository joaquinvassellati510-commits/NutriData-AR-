-- Objetivo:
--   Consolidar toda la lógica de negocio en una VIEW.
--   Versión corregida: Sin columna ID inexistente.

CREATE OR REPLACE VIEW `nutricion-ar.datos_nutricionales.vw_auditoria_consolidada` AS

WITH estandares_oms AS (
  SELECT 'BEBIDAS' as cat_std, 5 as limite_azucar_oms UNION ALL
  SELECT 'LACTEOS', 8 UNION ALL
  SELECT 'SNACKS', 10
)

SELECT 
    -- 1. Datos Identificatorios (Cambiamos id por nombre_producto como base)
    UPPER(TRIM(a.nombre_producto)) as producto,
    COALESCE(a.marca, 'Sin Marca') as marca,
    UPPER(a.categoria) as categoria,
    
    -- 2. Métricas Nutricionales
    a.azucares_100g,
    a.sodio_100g,
    
    -- 3. Lógica de Riesgo
    CASE 
        WHEN a.sodio_100g > 400 OR a.azucares_100g > 15 THEN '🔴 ALTO'
        WHEN a.sodio_100g > 200 OR a.azucares_100g > 8 THEN '🟡 MEDIO'
        ELSE '🟢 BAJO'
    END AS nivel_riesgo,

    -- 4. Validación OMS
    COALESCE(CAST(e.limite_azucar_oms AS STRING), 'No regulado') as limite_oms,
    CASE 
        WHEN a.azucares_100g > e.limite_azucar_oms THEN 'EXCEDE'
        WHEN e.limite_azucar_oms IS NULL THEN 'SIN DATO'
        ELSE 'CUMPLE'
    END AS cumplimiento_oms

FROM `nutricion-ar.datos_nutricionales.alimentos` AS a
LEFT JOIN estandares_oms AS e ON UPPER(a.categoria) = e.cat_std;


-- Objetivo: Validar la integridad de la vista consolidada
-- Verificamos que los emojis, la limpieza y los cruces legales funcionen.

SELECT * FROM `nutricion-ar.datos_nutricionales.vw_auditoria_consolidada`
ORDER BY azucares_100g DESC -- Ponemos los más dulces arriba para ver el cumplimiento
LIMIT 20;


