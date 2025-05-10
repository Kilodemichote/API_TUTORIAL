FROM python:3.10

WORKDIR /app

# Copiar archivos
COPY app.py .
COPY models/ ./models/

# Instalar dependencias
RUN pip install flask joblib scikit-learn

EXPOSE 5001

# Comando de inicio
CMD ["python", "app.py"]
