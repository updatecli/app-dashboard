<template>
  <v-container
      class="py-8 px-6"
      fluid
  >
    <v-container>
          <v-app-bar
            absolute
            dark
            dense
            height="48"
            elevation="0"
          >
            <v-list
              v-for="dashboardInfo in dashboards" :key="dashboardInfo.name"
              density="compact"
              class="justify-center"
              nav
              >
              <v-list-item
                :title="dashboardInfo.name"
                @click="getDashboardData(dashboardInfo.id);"
              ></v-list-item>
            </v-list>
          </v-app-bar>
    </v-container>

      <v-row v-for="project in getDashboard.projects"
              :key="project.name">
          <v-col
              cols="auto"
              lg="12"
              md="12"
              sm="12"
            >

          <!-- Show Project Description -->
          <v-row class="mx-auto">
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
                  <v-card-title align="center">{{ project.name }}</v-card-title>
                  <v-card-text align="center">
                    <p>{{ project.description }}</p>
                  </v-card-text>
                </v-card>
            </v-col>
          </v-row>


          <!-- For each project, show apps information-->
          <v-row class="mx-auto">
              <v-col
                  v-for="app in project.apps"
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
                  <v-card-title align="center">
                    <v-icon :icon=getStatusIcon(app.status)></v-icon>
                    {{ app.name}}</v-card-title>

                  <v-row>
                    <v-col>
                      <v-card-text align="center">
                        {{ app.description}}
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
                        <v-card-text align="center">{{ app.current.spec.version }}</v-card-text>
                      </v-col>
                      <v-col
                        cols="auto"
                        lg="6"
                        md="12"
                        sm="12"
                      >
                        <v-card-title align="center">Expected</v-card-title>
                        <v-card-text align="center">{{ app.expected.spec.version }}</v-card-text>
                      </v-col>
                    </v-row>
                  <v-row>
                    <v-col>
                      <v-card-text align="center">Updated At</v-card-text>
                      <v-card-subtitle align="center">
                      {{ app.updatedAt}}
                      </v-card-subtitle>
                    </v-col>
                  </v-row>
                </v-card>
              </v-col>
          </v-row>

        </v-col>
      </v-row>

  </v-container>
</template>

<script>
import axios from 'axios'

export default {
  name: 'ReleaseDashboard',

  data: () => ({
    dashboard: [],
    dashboards: [],
  }),

  computed: {
    getDashboard: function() {
      return this.dashboard
    },

  },

  beforeUnmount() {
    this.cancelAutoUpdate();
  },

  methods: {
    cancelAutoUpdate() {
      clearInterval(this.timer);
    },
    getDashboardData(id) {
      axios.get("/api/dashboards/" + id).then(response => {
            this.dashboard = response.data.data
        })
      //this.timer = setInterval(this.getDashboardData(id), 300000)
    },
    getStatusIcon: function(status){
      switch (status) {
        case 2:
          return "mdi-robot-love"
        case 3:
          return "mdi-robot-angry"
        case 4:
          return "mdi-robot-confused"
        default:
          return "mdi-robot-off"
      }
    }

  },

  async created() {
    try {
      const dashboards = await axios.get(`/api/dashboards`);
      this.dashboards = dashboards.data.data;
    } catch (error) {
      console.log(error);
    }
  },
}
</script>
