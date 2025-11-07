import { createRouter, createWebHistory } from 'vue-router';
import Pasteles from '../components/pasteles.vue';
import Ingredientes from '../components/ingredientes.vue';
import Reporte from '../components/reporte.vue';

const routes = [
  { path: '/', redirect: '/pasteles' },
  { path: '/pasteles', component: Pasteles },
  { path: '/ingredientes', component: Ingredientes },
  { path: '/reporte', component: Reporte }
];

export default createRouter({
  history: createWebHistory(),
  routes
});
