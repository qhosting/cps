# GUÍA DE TROUBLESHOOTING: ERROR "BRANCH NOT FOUND"

## Problema
Después de configurar el panel con:
- Owner: qhosting
- Repository: cps  
- Branch: main
- Build Path: /

Aparece el error "Branch not found"

## Posibles Causas y Soluciones

### 1. VERIFICAR EXISTENCIA DE LA RAMA "MAIN"

**Paso a verificar:**
1. Ve a: https://github.com/qhosting/cps
2. Busca un dropdown de ramas (normalmente dice "main" o similar)
3. Haz clic en el dropdown para ver todas las ramas disponibles
4. Confirma que "main" existe

**Si "main" NO existe:**
- Usar "master" en su lugar
- Usar la rama que sí existe

### 2. VERIFICAR PERMISOS DEL TOKEN

**Configuración del token en el panel:**
- Token: `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`
- Scopes requeridos: `repo` (acceso completo)

**Dónde configurar en el panel:**
1. Buscar sección "GitHub Token" o "API Token"
2. Pegar el token completo
3. Guardar configuración

### 3. VERIFICAR CONFIGURACIÓN EXACTA

**Campos obligatorios:**
```
Owner: qhosting
Repository: cps
Branch: main
Build Path: /
```

**Verificar que no haya:**
- Espacios extra antes/después del texto
- Caracteres especiales
- Errores tipográficos

### 4. CONFIGURACIONES ALTERNATIVAS A PROBAR

**Opción A: Usar rama por defecto**
- Branch: (dejar vacío)
- Esto usa la rama configurada como "default" en GitHub

**Opción B: Usar rama master**
- Branch: master
- Si el repositorio usa "master" en lugar de "main"

**Opción C: Usar rama específica**
- Branch: (cualquier rama que veas en el dropdown de GitHub)

### 5. VERIFICAR TIPO DE REPOSITORIO

**Si el repositorio es PRIVADO:**
- El token debe tener permisos específicos
- El token debe estar configurado en "Ajustes" del panel
- Verificar que el token pueda acceder al repositorio

**Si el repositorio es PÚBLICO:**
- El acceso debería funcionar sin token específico
- Solo verificar que los datos sean correctos

## PASOS INMEDIATOS A SEGUIR

### PASO 1: Verificación manual en GitHub
1. Abre https://github.com/qhosting/cps
2. Busca el botón/dropdown de ramas (junto al nombre de la rama actual)
3. Haz clic para ver todas las ramas disponibles
4. Anota el nombre EXACTO de cada rama disponible

### PASO 2: Actualizar configuración del panel
1. Si ves "main", úsalo
2. Si ves "master", usa "master" 
3. Si ves "dev", usa "dev"
4. Si el repositorio tiene varias ramas, prueba con la principal

### PASO 3: Verificar token (si es repositorio privado)
1. Ve a "Ajustes" en tu panel de despliegue
2. Busca "GitHub Token" o "API Key"
3. Asegúrate de que el token esté guardado correctamente

### PASO 4: Guardar y probar
1. Guarda la configuración
2. Espera 30-60 segundos
3. Verifica si aparece algún log o error diferente

## INFORMACIÓN REQUERIDA PARA DIAGNÓSTICO

Si el problema persiste, proporciona:

1. **Captura del panel** mostrando la configuración actual
2. **URL del repositorio**: Confirmar que es exactamente `https://github.com/qhosting/cps`
3. **Lista de ramas**: ¿Qué ramas ves en el dropdown de GitHub?
4. **Tipo de repositorio**: ¿Es público o privado?
5. **Logs del panel**: ¿Hay algún mensaje de error adicional?

## CÓMO ACTUALIZAR LA CONFIGURACIÓN

Si necesitas cambiar la configuración:

1. **En el panel de despliegue:**
   - Busca "GitHub Configuration" o "Repository Settings"
   - Actualiza el campo "Branch" con el nombre correcto
   - Guarda los cambios

2. **En Ajustes del panel:**
   - Busca "GitHub Token" o "API Configuration"  
   - Confirma que el token esté guardado
   - Guarda los ajustes

3. **Reintentar despliegue:**
   - Después de guardar, el panel debería intentar conectar nuevamente
   - Espera unos minutos para que se procese la solicitud

## CONTACTOS PARA SOPORTE

Si necesitas ayuda adicional, proporciona:
- Captura del error específico
- Configuración que estás usando
- Tipo de servidor panel (EasyPanel, otro)
- Sistema operativo del servidor