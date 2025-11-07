<template>
  <div>
    <h2>Gestión de Ingredientes</h2>
    <form @submit.prevent="guardarIngrediente">
      <input v-model="ingrediente.nombre" placeholder="Nombre" />
      <button type="submit">{{ ingrediente.id_ingrediente ? "Actualizar" : "Guardar" }}</button>
    </form>

    <hr />
    <h3>Lista de Ingredientes</h3>
    <ul>
      <li v-for="i in ingredientes" :key="i.id_ingrediente">
        {{ i.nombre }}
        <button @click="editarIngrediente(i)">Editar</button>
        <button @click="eliminarIngrediente(i.id_ingrediente)">Eliminar</button>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      ingredientes: [],
      ingrediente: { nombre: "" }
    };
  },
  mounted() {
    this.cargarIngredientes();
  },
  methods: {
    cargarIngredientes() {
      axios.get("http://localhost/pasteleria_crud/api/ingredientes.php").then(res => this.ingredientes = res.data);
    },
    guardarIngrediente() {
      const url = "http://localhost/pasteleria_crud/api/ingredientes.php";
      const method = this.ingrediente.id_ingrediente ? axios.put : axios.post;
      method(url, this.ingrediente).then(() => {
        this.cargarIngredientes();
        this.ingrediente = { nombre: "", descripcion: "", fecha_vencimiento: "" };
      });
    },
    editarIngrediente(i) {
      this.ingrediente = { ...i };
    },
    eliminarIngrediente(id) {
      axios.delete("http://localhost/pasteleria_crud/api/ingredientes.php", { data: { id_ingrediente: id } }).then(() => this.cargarIngredientes());
    }
  }
};
</script>
