<template>
  <v-container
      class="py-8 px-6"
      fluid
  >
      <v-row class="mx-auto" v-if="appsData.description">
        <v-col
            cols="auto"
            lg="12"
            md="12"
            sm="12"
          >
            <v-card
              elevation="3"
              shaped
              outline
              >
              <v-card-title align="center">Description</v-card-title>
              <v-card-text align="center">
                <p>{{ appsData.description }}</p>
              </v-card-text>
            </v-card>
        </v-col>
      </v-row>

      <v-row class="mx-auto">
          <v-col
              v-for="app in appsData.apps"
              :key="app.name"
              cols="auto"
              lg="4"
              md="12"
              sm="12"
          >
            <v-card
              elevation="3"
              shaped
              outline
              min-height="300"
              >
              <v-card-title align="center">{{ app.name}}</v-card-title>

              <v-row>
                <v-col>
                  <v-card-text align="center">
                    {{ app.description}}
                    {{ isMatching(app.currentValue, app.expectedValue) }}
                  </v-card-text>
                </v-col>
              </v-row>

                <v-row>
                  <v-col
                    cols="auto"
                    lg="6"
                    md="12"
                    sm="12"
                  >
                    <v-card-title align="center">Current</v-card-title>
                    <v-card-text align="center">{{ app.currentValue}}</v-card-text>
                  </v-col>
                  <v-col
                    cols="auto"
                    lg="6"
                    md="12"
                    sm="12"
                  >
                    <v-card-title align="center">Expected</v-card-title>
                    <v-card-text align="center">{{ app.expectedValue}}</v-card-text>
                  </v-col>
                </v-row>
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

  methods: {
    isMatching: function(currentValue, expectedValue) {
      return currentValue == expectedValue;
    }
  },

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