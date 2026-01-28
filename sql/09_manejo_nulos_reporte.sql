-- Objetivo:
--   Estandarizar la salida de reportes relacionales mediante el manejo
--   de valores nulos (NULLs) resultantes de JOINS.
--
-- Valor de negocio:
--   Asegura la integridad visual de los reportes y dashboards, 
--   evitando confusiones en la interpretación de datos por parte de 
--   usuarios no técnicos (gerentes, auditores).

WITH estandares_oms AS (
  SELECT 'BEBIDAS' as cat_std, 5 as limite_azucar_oms UNION ALL
  SELECT 'LACTEOS', 8
)

SELECT 
    a.nombre_producto, 
    a.categoria, 
    -- Si no hay límite, ponemos 0 en vez de NULL para no romper cálculos:
    COALESCE(e.limite_azucar_oms, 0) as limite_calculable,
    -- Si no hay límite, ponemos un texto explicativo:
    COALESCE(CAST(e.limite_azucar_oms AS STRING), 'No regulado') as estatus_legal
FROM `nutricion-ar.datos_nutricionales.alimentos` AS a
LEFT JOIN estandares_oms AS e ON UPPER(a.categoria) = e.cat_std;

--"Tratamiento de valores nulos con COALESCE para reportes de cumplimiento"--
