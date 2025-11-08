import { createRouter, createWebHistory } from 'vue-router';
import Pasteles from '../components/Pasteles.vue';
import Ingredientes from '../components/Ingredientes.vue';
import Reporte from '../components/Reporte.vue';

const routes = [
  { path: '/', redirect: '/pasteles' },
  { path: '/pasteles', name: 'Pasteles', component: Pasteles },
  { path: '/ingredientes', name: 'Ingredientes', component: Ingredientes },
  { path: '/reporte', name: 'Reporte', component: Reporte }
];

export default createRouter({
  history: createWebHistory(),
  routes
});
