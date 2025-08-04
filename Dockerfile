# Base image with Python
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Jupyter if you want to run notebooks in the container
RUN pip install jupyter

# Copy the notebooks
COPY notebooks/ ./notebooks/

# (Optional) Expose Jupyter port
EXPOSE 8888

# Command to start Jupyter
CMD ["jupyter", "notebook", "--notebook-dir=./notebooks", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
