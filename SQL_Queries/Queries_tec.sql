use Inst_tecnico

SELECT 
    p.nombre_programa,
    COUNT(*) AS total_estudiantes,
    SUM(CASE WHEN h.estado_academico IN ('Reprobado', 'Retirado') THEN 1 ELSE 0 END) AS total_reprobados_retirados,
    CAST(
        100.0 * SUM(CASE WHEN h.estado_academico IN ('Reprobado', 'Retirado') THEN 1 ELSE 0 END) 
        / COUNT(*) AS DECIMAL(5,2)
    ) AS porcentaje_reprobados_retirados
FROM hechos_academicoos h
JOIN dim_programas p ON h.id_programa = p.id_programa
GROUP BY p.nombre_programa
ORDER BY porcentaje_reprobados_retirados DESC;


SELECT 
    e.genero,
    AVG(h.promedio) AS promedio_academico,
    AVG(h.asistencia) AS promedio_asistencia
FROM hechos_academicoos h
JOIN dim_estudiantess e ON h.id_estudiante = e.id_estudiante
GROUP BY e.genero;

SELECT 
    i.nombre_instructor,
    AVG(h.promedio) AS promedio_general,
    AVG(h.asistencia) AS promedio_asistencia,
    COUNT(*) AS total_estudiantes
FROM hechos_academicoos h
JOIN dim_instructores i ON h.id_instructor = i.id_instructor
GROUP BY i.nombre_instructor
HAVING COUNT(*) >= 5  -- opcional: filtrar para evitar sesgos con pocos estudiantes
ORDER BY promedio_general DESC;


SELECT 
    s.nombre_sede,
    AVG(h.promedio) AS promedio_general,
    AVG(h.asistencia) AS promedio_asistencia
FROM hechos_academicoos h
JOIN dim_sedess s ON h.id_sede = s.id_sede
GROUP BY s.nombre_sede
ORDER BY promedio_general DESC;


