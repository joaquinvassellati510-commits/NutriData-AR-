-- Objetivo:
--   Analizar el perfil nutricional promedio por categoría de producto
--   para identificar qué segmentos del mercado presentan mayores niveles
--   de nutrientes críticos (sodio y azúcar).
--
-- Valor de negocio:
--   Provee información clave para auditorías de salud pública, 
--   permite el benchmarking entre categorías y fundamenta la toma 
--   de decisiones estratégicas en el desarrollo de productos saludables.

SELECT 
    categoria, 
    COUNT(*) as total_productos,
    ROUND(AVG(sodio_100g), 2) as promedio_sodio,
    ROUND(AVG(azucares_100g), 2) as promedio_azucar
FROM `nutricion-ar.datos_nutricionales.alimentos`
GROUP BY categoria
-- Filtro de relevancia: solo categorías con una muestra representativa
HAVING total_productos > 5 
ORDER BY promedio_azucar DESC;

--"Uso de funciones de agregación (AVG, COUNT) y filtros de grupo (HAVING) para el análisis estadístico por categoría alimentaria"--
