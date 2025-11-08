<template>
  <div class="container">
    <h2>Reporte de Pasteles e Ingredientes</h2>
    <table>
      <thead>
        <tr>
          <th>Pastel</th>
          <th>Preparado por</th>
          <th>Descripción</th>
          <th>Ingredientes</th>
          <th>Creado</th>
          <th>Vencimiento</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="p in pasteles" :key="p.id_pastel">
          <td>{{ p.nombre }}</td>
          <td>{{ p.preparado_por }}</td>
          <td>{{ p.descripcion }}</td>
          <td class="ingredientes">{{ p.ingredientes || 'Sin ingredientes' }}</td>
          <td>{{ p.fecha_creado }}</td>
          <td>{{ p.fecha_vencimiento }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from "axios";
import '../assets/styles/reportePasteles.css';

export default {
  data() {
    return { pasteles: [] };
  },
  mounted() {
    axios.get("http://localhost/pasteleria_crud/api/pasteles.php")
      .then(res => this.pasteles = res.data);
  }
};
</script>
