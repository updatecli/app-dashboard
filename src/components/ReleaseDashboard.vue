<template>
  <v-container
      class="py-8 px-6"
      fluid
  >
      <v-row>
          <v-col
              v-for="app in appsData.apps"
              :key="app.name"
              cols="4"
          >
            <v-card
              elevation="3"
              shaped
              outline
              max-width="374"
              class="mx-auto my=12">
              <v-card-title align="center">{{ app.name}}</v-card-title>
              <v-divider></v-divider>
              <v-card-text align="center">Current:{{ app.currentValue}}</v-card-text>
              <v-spacer></v-spacer>
              <v-card-text align="center">Expected{{ app.expectedValue}}</v-card-text>
            </v-card>

          </v-col>
      </v-row>
  </v-container>
</template>

<script>
import axios from 'axios'

export default {
  name: 'ReleaseDashboard',

  data: () => ({
    appsData: []
  }),

  async created() {
    try {
      const res = await axios.get(`/data.json`);
      this.appsData = res.data;
    } catch (error) {
      console.log(error);
    }
  },
}
</script>