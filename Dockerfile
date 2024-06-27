# Usa una imagen oficial de Node.js 18 como base para el build
FROM node:18 as build

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto del código de la aplicación
COPY . .

# Construye la aplicación Angular
RUN npm run build --prod

# Usa una imagen de Nginx para servir la aplicación
FROM nginx:alpine

# Copia los archivos de build al directorio de Nginx
COPY --from=build /app/dist/frontend /usr/share/nginx/html

# Expone el puerto 80
EXPOSE 80

# Comando para ejecutar Nginx
CMD ["nginx", "-g", "daemon off;"]