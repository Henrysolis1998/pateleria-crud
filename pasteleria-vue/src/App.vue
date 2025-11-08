<template>
  <div id="app">
    <nav class="navbar">
      <router-link to="/pasteles" class="nav-link">🎂 Pasteles</router-link>
      <router-link to="/ingredientes" class="nav-link">🥣 Ingredientes</router-link>
      <router-link to="/reporte" class="nav-link">📋 Reporte</router-link>
    </nav>

    <main class="main-content">
      <router-view />
    </main>
  </div>
</template>

<style scoped>
/* Barra de navegación */
.navbar {
  background: linear-gradient(90deg, #ff7b7b, #ffb347);
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 2rem;
  padding: 1rem 0;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

/* Enlaces */
.nav-link {
  color: white;
  text-decoration: none;
  font-weight: bold;
  font-size: 1.1rem;
  transition: 0.3s;
}

.nav-link:hover {
  color: #222;
  background: rgba(255, 255, 255, 0.3);
  padding: 0.4rem 0.8rem;
  border-radius: 8px;
}

/* Contenido principal */
.main-content {
  padding: 2rem;
  max-width: 900px;
  margin: auto;
}
</style>
