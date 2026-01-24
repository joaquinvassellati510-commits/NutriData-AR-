
-- Objetivo:
--   Preparar el dataset para análisis nutricional confiable mediante:
--   - Normalización de nombres de categorías y marcas
--   - Conversión de campos nutricionales a formato numérico (azúcar y sodio)
--   - Eliminación o tratamiento de valores nulos

-- Valor de negocio:
--   Garantiza calidad de datos para métricas, auditorías nutricionales
--   y decisiones basadas en información consistente.

SELECT nombre_producto, marca, azucares_100g
FROM `nutricion-ar.datos_nutricionales.alimentos`
WHERE LOWER(categoria) = 'bebidas'


--Identificar exceso de azúcar
SELECT *
FROM `nutricion-ar.datos_nutricionales.alimentos`
WHERE azucares_100g > 10
ORDER BY azucares_100g DESC

--Filtros combinados (La lupa del nutricionista)
--Busquemos productos que sean críticos tanto en sodio como en sellos.

SELECT nombre_producto, sodio_100g, cantidad_sellos
FROM `nutricion-ar.datos_nutricionales.alimentos`
WHERE sodio_100g > 400 OR cantidad_sellos > 2
