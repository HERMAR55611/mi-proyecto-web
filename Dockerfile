FROM ubuntu
MAINTAINER Luis Vargas "lanvargas@corhuila.edu.co"

# Actualiza los paquetes
RUN apt-get update
# Instala Nginx
RUN apt-get install -y nginx

# Copia los archivos de la carpeta 'web' al contenedor
ADD web /var/www/html/

# Inicia Nginx en el contenedor
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]

# Expone el puerto 80 para el servidor web
EXPOSE 80
