# Étape 1 : Construire l'application avec Node.js
FROM node:18 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier et installer les dépendances
COPY package.json package-lock.json ./
RUN npm install

# Copier tout le code source
COPY . .

# Construire l'application
RUN npm run build

# Étape 2 : Utiliser Nginx pour servir l'application
FROM nginx:alpine

# Copier les fichiers buildés vers Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Exposer le port 80 pour Render
EXPOSE 80

# Lancer Nginx
CMD ["nginx", "-g", "daemon off;"]
