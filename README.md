# Análisis Académico - Instituto Técnico Laboral "Talento Futuro"

## 📊 Descripción del Proyecto

Análisis integral de datos académicos utilizando metodologías ágiles y behavioral economics para identificar factores críticos que afectan el desempeño estudiantil y la retención en el Instituto Técnico Laboral "Talento Futuro".

### 🎯 Objetivo Principal
Generar insights accionables basados en datos para fortalecer la toma de decisiones institucionales y apoyar el proceso de acreditación de alta calidad.

## 🛠️ Stack Tecnológico

- **SQL**: Consultas y análisis de datos
- **Python**: EDA y ETL con Pandas
- **Power BI**: Visualización y dashboards interactivos
- **Metodología**: Design Thinking centrado en el usuario
- **Framework**: Behavioral Economics para insights estratégicos

## 📁 Estructura del Proyecto

```
proyecto-analisis-academico/
│
├── data/
│   ├── raw/                    # Datos brutos
│   ├── processed/              # Datos procesados
│   └── outputs/                # Resultados y exports
│
├── notebooks/
│   ├── 01_eda_academico.ipynb  # Análisis exploratorio
│   ├── 02_etl_transform.ipynb  # Transformación de datos
│   └── 03_behavioral_insights.ipynb # Insights conductuales
│
├── sql/
│   ├── queries_analiticas.sql  # Consultas SQL principales
│   └── vistas_estratégicas.sql # Vistas para reporting
│
├── powerbi/
│   └── dashboard_academico.pbix # Dashboard interactivo
│
└── docs/
    └── insights_estrategicos.md # Recomendaciones accionables
```

## 🔍 Metodología

### Design Thinking Centrado en el Estudiante
1. **Empatizar**: Entender las necesidades reales de estudiantes e instructores
2. **Definir**: Identificar problemas críticos de retención y desempeño
3. **Idear**: Generar soluciones basadas en behavioral economics
4. **Prototipar**: Crear intervenciones mínimas viables
5. **Testear**: Implementar y medir impacto

### Behavioral Economics Framework
- **Sesgos identificados**: Efecto arrastre, aversión a la pérdida, inercia organizacional
- **Palancas conductuales**: Prueba social, metas progresivas, gamificación
- **Intervenciones**: Nudges para mejorar retención y desempeño

## 📈 Principales Hallazgos

### 🎯 Insights Accionables con Behavioral Economics

#### 1. **Popularidad ≠ Buen Rendimiento**
- **Sesgo**: Efecto arrastre (bandwagon effect)
- **Hallazgo**: Marketing Digital (programa más popular) tiene alto riesgo de deserción (~30%)
- **Acción**: Implementar test de afinidad vocacional pre-matrícula

#### 2. **Estigma en Tutorías**
- **Sesgo**: Miedo al estigma + aversión a la pérdida
- **Hallazgo**: 533 estudiantes en riesgo no buscan ayuda
- **Acción**: Renombrar como "Programa de Nivelación para Acelerar Avance"

#### 3. **Asignación Subóptima de Instructores**
- **Sesgo**: Inercia organizacional
- **Hallazgo**: Mejores instructores no están en programas críticos
- **Acción**: Reasignación estratégica + gamificación de rankings

#### 4. **Disparidad entre Sedes**
- **Sesgo**: Efecto contexto
- **Hallazgo**: Sede Centro tiene mejor desempeño (3.56 vs 3.39 promedio)
- **Acción**: Replicar prácticas exitosas + mensajes de aspiración social

#### 5. **Ausentismo por Estrato**
- **Sesgo**: Mentalidad de escasez
- **Hallazgo**: Estratos 1-2 tienen mayor inasistencia
- **Acción**: Micro-becas de asistencia + metas semanales

## 💾 Consultas SQL Principales

```sql
-- Programas con mayor riesgo de deserción
SELECT 
    p.nombre_programa,
    COUNT(CASE WHEN ea.estado_academico = 'En Riesgo' THEN 1 END) * 100.0 / COUNT(*) as porcentaje_riesgo
FROM hechos_academicos ha
JOIN programas p ON ha.id_programa = p.id_programa
JOIN estado_academico ea ON ha.estado_academico = ea.estado
GROUP BY p.nombre_programa
ORDER BY porcentaje_riesgo DESC;

-- Efectividad de instructores por programa
SELECT 
    i.nombre_instructor,
    p.nombre_programa,
    AVG(ha.promedio) as promedio_academico,
    AVG(ha.asistencia) as asistencia_promedio
FROM hechos_academicos ha
JOIN instructores i ON ha.id_instructor = i.id_instructor
JOIN programas p ON ha.id_programa = p.id_programa
GROUP BY i.nombre_instructor, p.nombre_programa
ORDER BY promedio_academico DESC;

-- Análisis demográfico vs desempeño
SELECT 
    d.estrato,
    d.genero,
    AVG(ha.promedio) as promedio_academico,
    AVG(ha.asistencia) as asistencia_promedio,
    COUNT(CASE WHEN ha.estado_academico = 'Retirado' THEN 1 END) as retirados
FROM hechos_academicos ha
JOIN datos_demograficos d ON ha.id_estudiante = d.id_estudiante
GROUP BY d.estrato, d.genero;
```

## 🐍 Análisis Python (Pandas)

```python
# EDA Básico
print("=== Distribución de Estados Académicos ===")
print(df['estado_academico'].value_counts(normalize=True))

# Correlaciones clave
correlation_matrix = df[['promedio', 'asistencia', 'edad', 'estrato']].corr()

# Análisis por segmentos
segment_analysis = df.groupby(['id_programa', 'estrato']).agg({
    'promedio': 'mean',
    'asistencia': 'mean',
    'id_estudiante': 'count'
}).round(2)
```

## 📊 Dashboard Power BI

**Métricas Principales:**
- Tasa de retención por programa/sede
- Desempeño académico vs variables demográficas
- Efectividad de instructores
- Alertas tempranas de estudiantes en riesgo

**Filtros Interactivos:**
- Por programa académico
- Por sede
- Por rango de fecha
- Por estrato socioeconómico

## 🚀 Implementación Recomendada

### Fase 1: Intervenciones Inmediatas (30 días)
1. Renombrar programa de tutorías
2. Comunicar rankings de instructores destacados
3. Implementar test de afinidad vocacional

### Fase 2: Estrategias Mediano Plazo (90 días)
1. Reasignación estratégica de instructores
2. Programa de micro-becas por asistencia
3. Réplica de mejores prácticas entre sedes

### Fase 3: Optimización Continua
1. Sistema de alertas tempranas
2. Dashboard en tiempo real
3. Mediciones A/B de intervenciones

## 📋 Métricas de Éxito

| Métrica | Línea Base | Meta 90 días |
|---------|------------|--------------|
| Tasa retención | 67% | 75% |
| Estudiantes en riesgo | 35% | 25% |
| Asistencia estratos 1-2 | 78% | 85% |
| Satisfacción instructores | - | +15% |

## 👥 Equipo y Roles

- **Científico de Datos**: Análisis EDA y modelado
- **Analista BI**: Dashboards y reporting
- **Especialista Behavioral**: Diseño de intervenciones
- **Líder Académico**: Implementación estratégica

## 📄 Licencia

Este proyecto es para uso interno del Instituto Técnico Laboral "Talento Futuro".

---

**¿Preguntas o colaboraciones?** Abre un issue o contacta al equipo de análisis de datos.

---
*Última actualización: ${new Date().toLocaleDateString()}*
