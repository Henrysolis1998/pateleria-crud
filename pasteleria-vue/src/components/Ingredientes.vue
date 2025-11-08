<template>
  <div class="container">
    <h2>Ingredientes</h2>

    <div class="form-card">
      <form @submit.prevent="guardarIngrediente">
        <input v-model="ingrediente.nombre" placeholder="Nombre del ingrediente" />
        <button type="submit" class="btn-primary">{{ ingrediente.id_ingrediente ? "Actualizar" : "Guardar" }}</button>
      </form>
    </div>

    <h3>Lista de Ingredientes</h3>
    <div class="ingrediente-list">
      <div v-for="i in ingredientes" :key="i.id_ingrediente" class="ingrediente-card">
        <span>{{ i.nombre }}</span>
        <div class="card-buttons">
          <button class="btn-edit" @click="editarIngrediente(i)">Editar</button>
          <button class="btn-delete" @click="eliminarIngrediente(i.id_ingrediente)">Eliminar</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import '../assets/styles/ingredientes.css';

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
      axios.get("http://localhost/pasteleria_crud/api/ingredientes.php")
        .then(res => this.ingredientes = res.data);
    },
    guardarIngrediente() {
      const url = "http://localhost/pasteleria_crud/api/ingredientes.php";
      const method = this.ingrediente.id_ingrediente ? axios.put : axios.post;
      method(url, this.ingrediente).then(() => {
        this.cargarIngredientes();
        this.ingrediente = { nombre: "" };
      });
    },
    editarIngrediente(i) {
      this.ingrediente = { ...i };
    },
    eliminarIngrediente(id) {
      axios.delete("http://localhost/pasteleria_crud/api/ingredientes.php", { data: { id_ingrediente: id } })
        .then(() => this.cargarIngredientes());
    }
  }
};
</script>
