<template>
  <div class="container">
    <h2>Ingreso de Pasteles</h2>

    <div class="form-card">
      <form @submit.prevent="guardarPastel">
        <input v-model="pastel.nombre" placeholder="Nombre" />
        <textarea v-model="pastel.descripcion" placeholder="Descripción"></textarea>
        <input v-model="pastel.preparado_por" placeholder="Preparado por" />
        <input type="date" v-model="pastel.fecha_creado" />
        <input type="date" v-model="pastel.fecha_vencimiento" />

        <h4>Seleccionar Ingredientes</h4>
        <div v-for="ing in ingredientes" :key="ing.id_ingrediente">
          <input type="checkbox" :value="ing.id_ingrediente" v-model="pastel.ingredientes" />
          {{ ing.nombre }}
        </div>

        <button type="submit" class="btn-primary">{{ pastel.id_pastel ? "Actualizar" : "Guardar" }}</button>
      </form>
    </div>

    <h3>Lista de Pasteles</h3>
    <div class="pastel-list">
      <div v-for="p in pasteles" :key="p.id_pastel" class="pastel-card">
        <div class="pastel-info">
          <strong>{{ p.nombre }}</strong><br/>
          {{ p.descripcion }}<br/>
          Creado: {{ p.fecha_creado }}<br/>
          Vencimiento: {{ p.fecha_vencimiento }}
          <div class="card-buttons">
            <button class="btn-edit" @click="editarPastel(p)">Editar</button>
            <button class="btn-delete" @click="eliminarPastel(p.id_pastel)">Eliminar</button>
          </div>
        </div>
        <div class="pastel-ingredientes">
          <strong>Ingredientes:</strong>
          <ul>
            <li v-for="ing in (p.ingredientes ? p.ingredientes.split(', ') : [])" :key="ing">{{ ing }}</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import '../assets/styles/pasteles.css';

export default {
  data() {
    return {
      pasteles: [],
      ingredientes: [],
      pastel: { nombre: "", descripcion: "", preparado_por: "", fecha_creado: "", fecha_vencimiento: "", ingredientes: [] }
    };
  },
  mounted() {
    this.cargarPasteles();
    this.cargarIngredientes();
  },
  methods: {
    cargarPasteles() {
      axios.get("http://localhost/pasteleria_crud/api/pasteles.php")
        .then(res => this.pasteles = res.data);
    },
    cargarIngredientes() {
      axios.get("http://localhost/pasteleria_crud/api/ingredientes.php")
        .then(res => this.ingredientes = res.data);
    },
    guardarPastel() {
      const url = "http://localhost/pasteleria_crud/api/pasteles.php";
      const method = this.pastel.id_pastel ? axios.put : axios.post;
      method(url, this.pastel).then(() => {
        this.cargarPasteles();
        this.pastel = { nombre: "", descripcion: "", preparado_por: "", fecha_creado: "", fecha_vencimiento: "", ingredientes: [] };
      });
    },
    editarPastel(p) {
      this.pastel = { ...p, ingredientes: p.ingredientes ? p.ingredientes.split(', ') : [] };
    },
    eliminarPastel(id) {
      axios.delete("http://localhost/pasteleria_crud/api/pasteles.php", { data: { id_pastel: id } })
        .then(() => this.cargarPasteles());
    }
  }
};
</script>
