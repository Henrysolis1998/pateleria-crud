<template>
  <div>
    <h2>Gestión de Pasteles</h2>

    <form @submit.prevent="guardarPastel">
      <input v-model="pastel.nombre" placeholder="Nombre" />
      <textarea v-model="pastel.descripcion" placeholder="Descripción"></textarea>
      <input v-model="pastel.preparado_por" placeholder="Preparado por" />
      <input type="date" v-model="pastel.fecha_vencimiento" />
      
      <h4>Seleccionar Ingredientes</h4>
      <div v-for="ing in ingredientes" :key="ing.id_ingrediente">
        <input type="checkbox" :value="ing.id_ingrediente" v-model="pastel.ingredientes" />
        {{ ing.nombre }}
      </div>
      
      <button type="submit">{{ pastel.id_pastel ? "Actualizar" : "Guardar" }}</button>
    </form>

    <hr />
    <h3>Lista de Pasteles</h3>
    <ul>
      <li v-for="p in pasteles" :key="p.id_pastel">
        <strong>{{ p.nombre }}</strong> - {{ p.descripcion }}<br/>
        Ingredientes: {{ p.ingredientes || 'Sin ingredientes' }}<br/>
        <button @click="editarPastel(p)">Editar</button>
        <button @click="eliminarPastel(p.id_pastel)">Eliminar</button>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      pasteles: [],
      ingredientes: [],
      pastel: { nombre: "", descripcion: "", preparado_por: "", fecha_vencimiento: "", ingredientes: [] }
    };
  },
  mounted() {
    this.cargarPasteles();
    this.cargarIngredientes();
  },
  methods: {
    cargarPasteles() {
      axios.get("http://localhost/pasteleria_crud/api/pasteles.php").then(res => this.pasteles = res.data);
    },
    cargarIngredientes() {
      axios.get("http://localhost/pasteleria_crud/api/ingredientes.php").then(res => this.ingredientes = res.data);
    },
    guardarPastel() {
      const url = "http://localhost/pasteleria_crud/api/pasteles.php";
      const method = this.pastel.id_pastel ? axios.put : axios.post;
      method(url, this.pastel).then(() => {
        this.cargarPasteles();
        this.pastel = { nombre: "", descripcion: "", preparado_por: "", fecha_vencimiento: "", ingredientes: [] };
      });
    },
    editarPastel(p) {
      this.pastel = { ...p, ingredientes: [] };
    },
    eliminarPastel(id) {
      axios.delete("http://localhost/pasteleria_crud/api/pasteles.php", { data: { id_pastel: id } }).then(() => this.cargarPasteles());
    }
  }
};
</script>
