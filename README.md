# API_TUTORIAL

## Créditos

Los créditos correspondientes son de:  
[gitbook/miguelevangelista/api-rest-and-machine-learning/docker](https://miguelevangelista.gitbook.io/herramientasavanzadas/ejemplos/api-rest-and-machine-learning/docker)

---
# Vamos a usar Docker en este tutorial

**¿Qué es Docker?**

Docker es una herramienta que te ayuda a crear, empacar y correr aplicaciones dentro de algo llamado contenedores. Un contenedor es como una cajita ligera y separada que tiene todo lo que tu aplicación necesita para funcionar: el código, las cosas que usa y el sistema.

## ¿Para qué sirve Docker?

- Junta tu aplicación con todo lo que necesita en una imagen.
- Corre esa imagen en contenedores que puedes usar en cualquier computadora con Docker.
- Así evitas problemas de que algo funcione en tu computadora pero no en otras, porque todo funciona igual en cualquier lugar: desarrollo, pruebas o producción.

# Agregar archivos Docker a la carpeta `machine_learning_api`

En esta carpeta vamos a crear dos archivos importantes: `Dockerfile` y `docker-compose.yml`.

---

## Dockerfile

Este archivo indica cómo crear la imagen Docker para nuestra aplicación.

```dockerfile
FROM python:3.10

WORKDIR /app

# Copiar archivos
COPY app.py .
COPY models/ ./models/

# Instalar dependencias
RUN pip install flask joblib scikit-learn

EXPOSE 5001

# Comando para iniciar la app
CMD ["python", "app.py"]
```

---
# ¿Qué es docker-compose?

Docker-compose es una herramienta que te permite crear y manejar varias aplicaciones o servicios Docker a la vez, usando un solo archivo para configurarlos todos.

Esto es muy útil cuando tu proyecto necesita diferentes partes que trabajen juntas, por ejemplo, una API hecha con Flask y una base de datos como PostgreSQL o MongoDB.

---

## Ejemplo de archivo `docker-compose.yml`

```yaml
version: "3.8"

services:
  iris-api:
    build: .
    ports:
      - "5001:5001"
    volumes:
      - ./models:/app/models
```
# Cómo levantar tu proyecto con Docker

1. Abre **Docker Desktop** en tu computadora.

2. Abre la terminal (consola) y navega a la carpeta donde está tu proyecto, por ejemplo:  
   `machine_learning_api`

3. Ejecuta el siguiente comando para construir la imagen y levantar los contenedores:

```bash
docker-compose up --build
```

---
# Deploy de la API en Render

Para subir nuestra API a producción en Render, sigue estos pasos:

---

## Preparación del repositorio

- Crea un repositorio con los archivos del proyecto que ya tienes:
  - Código de la API_TUTORIAL.
  - Dockerfile y configuración de Docker.

- En el archivo `requirements.txt`, agrega el módulo **gunicorn**.  
  Esto es necesario para que Render pueda ejecutar correctamente la aplicación en producción.

---

## Crear cuenta en Render

1. Ve a [https://render.com/](https://render.com/)  
2. Regístrate haciendo **Sign-Up** o inicia sesión con **Sign-In**.

---

## Configurar el servicio en Render

1. Una vez dentro de tu cuenta, accederás al dashboard:  
   [https://dashboard.render.com/](https://dashboard.render.com/)

2. Haz clic en el botón **+** y selecciona **Web Service**.

3. Conecta tu repositorio de GitHub (o la plataforma que uses), selecciona el repositorio con tu proyecto.

4. Asigna un nombre a tu servicio.

5. Selecciona **Python** como lenguaje para tu servicio web.

6. Verifica que el branch esté configurado en `main`.

7. Asegúrate que los comandos estén configurados así (según tu proyecto):

   - **Build Command:**  
     ```bash
     pip install -r requirements.txt
     ```

   - **Start Command:**  
     ```bash
     gunicorn app:app --bind 0.0.0.0:$PORT
     ```

8. Selecciona el plan gratuito para el servicio.

9. Haz clic en **Deploy Web Service**.

---

## Resultado

- Si todo está bien, Render empezará a construir y desplegar tu API.

- Cuando termine, podrás visitar tu API en una URL como esta:  
  `https://API_TUTORIAL.onrender.com/`


