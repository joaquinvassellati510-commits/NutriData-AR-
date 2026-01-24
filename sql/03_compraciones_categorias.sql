-- Objetivo:
--   Analizar la distribución del nivel de riesgo nutricional
--   por categoría de producto para detectar segmentos críticos
--   del mercado alimentario.
--
-- Valor de negocio:
--   Apoya la toma de decisiones en salud pública, priorización
--   de auditorías y estrategias de control de calidad.


WITH datos_sucios AS (
  SELECT 1 as id, ' Galletitas de Avena' as nombre, NULL as marca, ' SNACKS ' as categoria, 450 as kcal
  UNION ALL SELECT 2, 'jugo de naranja', 'MarcaPropia', 'bebida', NULL
  UNION ALL SELECT 3, 'Yogur con Cereales', 'La Serenísima', 'Lácteos', 110
)

-- Ahora aplicamos la LIMPIEZA sobre esos datos
SELECT 
    id,
    UPPER(TRIM(nombre)) as nombre_limpio, -- Quitamos espacios y ponemos en mayúsculas
    COALESCE(marca, 'Sin Marca') as marca_final, -- Reemplazamos el NULL por un texto
    TRIM(UPPER(categoria)) as categoria_limpia,
    COALESCE(kcal, 0) as kcal_final -- Si no tiene calorías, ponemos 0 para que no rompa el promedio
FROM datos_sucios

--"Uso de tablas temporales (CTE) para procesar y limpiar datos sin modificar la fuente original"--


