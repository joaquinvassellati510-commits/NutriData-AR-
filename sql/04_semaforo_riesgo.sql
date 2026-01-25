
-- Objetivo:
--   Clasificar automáticamente productos según nivel de riesgo nutricional
--   utilizando reglas de negocio basadas en la Ley de Etiquetado Frontal (AR)
--   mediante lógica CASE WHEN sobre azúcar y sodio.

-- Valor de negocio:
--   Automatiza auditorías nutricionales y facilita la detección masiva
--   de productos de alto riesgo para análisis regulatorio y competitivo.

-- Reglas de clasificación:
--   🔴 Alto riesgo: sodio > 400 mg OR azúcar > 15 g por 100 g
--   🟡 Riesgo medio: sodio > 200 mg OR azúcar > 8 g por 100 g
--   🟢 Bajo riesgo: resto de los casos


SELECT 
    nombre_producto,
    marca,
    sodio_100g,
    azucares_100g,
    -- Iniciamos la lógica del semáforo:
    CASE 
        WHEN sodio_100g > 400 OR azucares_100g > 15 THEN '🔴 ALTO RIESGO'
        WHEN sodio_100g > 200 OR azucares_100g > 8 THEN '🟡 RIESGO MEDIO'
        ELSE '🟢 BAJO RIESGO'
    END AS nivel_riesgo_nutricional
FROM nutricion-ar.datos_nutricionales.alimentos
ORDER BY nivel_riesgo_nutricional ASC;
