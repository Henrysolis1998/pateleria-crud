<template>
  <div>
    <h2>Reporte de Pasteles e Ingredientes</h2>
    <table border="1" cellpadding="6">
      <thead>
        <tr>
          <th>Pastel</th>
          <th>Preparado por</th>
          <th>Descripción</th>
          <th>Ingredientes</th>
          <th>Vencimiento</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="p in pasteles" :key="p.id_pastel">
          <td>{{ p.nombre }}</td>
          <td>{{ p.preparado_por }}</td>
          <td>{{ p.descripcion }}</td>
          <td>{{ p.ingredientes }}</td>
          <td>{{ p.fecha_vencimiento }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return { pasteles: [] };
  },
  mounted() {
    axios.get("http://localhost/pasteleria_crud/api/pasteles.php").then(res => this.pasteles = res.data);
  }
};
</script>
