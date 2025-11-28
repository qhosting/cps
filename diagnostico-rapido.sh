#!/bin/bash

# Script de diagnóstico directo
echo "=== DIAGNÓSTICO RÁPIDO DEL PROBLEMA ==="
echo ""

echo "PASO 1: Verifica estos campos EXACTOS en tu panel:"
echo "✓ Owner: qhosting"
echo "✓ Repository: cps"
echo "✓ Branch: main (asegúrate que esta rama existe en GitHub)"
echo "✓ Build Path: /"
echo ""

echo "PASO 2: Verifica manualmente en GitHub:"
echo "1. Ve a: https://github.com/qhosting/cps"
echo "2. Busca el botón de ramas (debería decir 'main' o similar)"
echo "3. Haz clic para ver todas las ramas disponibles"
echo "4. Anota qué ramas ves disponibles"
echo ""

echo "PASO 3: Verifica el token de GitHub:"
echo "Token actual: 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"
echo "Debería estar configurado en 'Ajustes' del panel"
echo ""

echo "PASO 4: Soluciones comunes:"
echo "A. Si la rama es 'master' en lugar de 'main':"
echo "   - Cambia el campo Branch a 'master'"
echo ""
echo "B. Si hay múltiples ramas:"
echo "   - Prueba con la rama principal (puede ser 'dev', 'production', etc.)"
echo ""
echo "C. Si el repositorio es privado:"
echo "   - Asegúrate que el token tenga permisos 'repo'"
echo ""

echo "=== ACCIÓN INMEDIATA REQUERIDA ==="
echo ""
echo "Por favor:"
echo "1. Ve a https://github.com/qhosting/cps"
echo "2. Mira las ramas disponibles (dropdown)"
echo "3. Usa el nombre EXACTO de la rama que quieras desplegar"
echo "4. Actualiza el campo 'Branch' en tu panel"
echo "5. Guarda la configuración"