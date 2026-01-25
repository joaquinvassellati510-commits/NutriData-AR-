
-- Objetivo:
--   Explorar el dataset nutricional mediante filtros y consultas
--   para identificar productos con alto contenido de azúcar y sodio
--   dentro de categorías específicas.

-- Valor de negocio:
--   Permite detectar rápidamente productos de alto riesgo
--   y enfocar auditorías nutricionales y acciones correctivas
--   en segmentos críticos del mercado.

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
